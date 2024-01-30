# frozen_string_literal: true

require 'mail'
require 'stringio'
require 'zip'
require 'zip/filesystem'
require 'zlib'

module EmailReportProcessor
  class Base
    attr_reader :index_name

    def initialize(client:)
      @client = client
    end

    def report(_report)
      raise 'Should not be called. Override this method and call #send_report'
    end

    def send_report(report)
      @client.index(index: index_name, body: report)
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
