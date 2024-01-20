# frozen_string_literal: true

require 'mail'
require 'net/http'
require 'stringio'
require 'zip'
require 'zip/filesystem'
require 'zlib'

module EmailReportProcessor
  class Base
    def report(_raw_report)
      raise 'Should not be called. Override this method and call #send_report'
    end

    def send_report(uri, data)
      req = Net::HTTP::Post.new(uri)
      req.body = data
      req.content_type = 'application/json'
      req.basic_auth(uri.user, uri.password)

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        res = http.request(req)
        puts res.inspect
        puts res.body.inspect
      end
    end

    def process_message(mail)
      attachement = mail.attachments.first
      process_attachment(attachement.content_disposition, attachement.body.decoded)
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
