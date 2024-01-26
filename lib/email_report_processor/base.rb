# frozen_string_literal: true

require 'mail'
require 'net/http'
require 'stringio'
require 'zip'
require 'zip/filesystem'
require 'zlib'

module EmailReportProcessor
  class Base
    attr_reader :http, :uri

    def initialize(endpoint:, username: 'admin', password: 'admin', hostname: 'localhost', port: 9200)
      @uri = URI("https://#{username}:#{password}@#{hostname}:#{port}#{endpoint}/_doc")
      @http = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE)
    end

    def report(_raw_report)
      raise 'Should not be called. Override this method and call #send_report'
    end

    def send_report(report)
      req = Net::HTTP::Post.new(uri)
      req.body = report
      req.content_type = 'application/json'
      req.basic_auth(uri.user, uri.password)

      res = http.request(req)
      puts res.inspect
      puts res.body.inspect
    end

    def process_message(mail)
      part = mail.attachments.first || mail
      filename = part['Content-Disposition'].filename

      process_attachment(filename, part.body.decoded)
    end

    def process_attachment(name, content)
      raw_report = read_attachment(name, content)
      report(raw_report)
    end

    def read_attachment(name, content)
      if name.end_with?('.gz')
        Zlib::GzipReader.new(StringIO.new(content)).read
      elsif name.end_with?('.zip')
        zip = Zip::File.open_buffer(content)
        zip.file.open("#{File.basename(name, '.zip')}.xml").read
      else
        raise %(Could not process attachement "#{name}")
      end
    end
  end
end
