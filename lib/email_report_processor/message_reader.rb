# frozen_string_literal: true

require 'email_report_processor/reports/dmarc'
require 'email_report_processor/reports/tlsrpt'

require 'zip'
require 'zip/filesystem'

module EmailReportProcessor
  class MessageReader
    attr_reader :errors

    def initialize
      @reports = [
        Reports::Dmarc,
        Reports::Tlsrpt,
      ]
      @errors = []
    end

    def process_message(message)
      part = message.attachments.first || message
      content_disposition = part['Content-Disposition']
      raise 'Missing Content-Disposition header' unless content_disposition

      process_attachment(content_disposition.filename, part.body.decoded)
    rescue StandardError => e
      message['X-Email-Report-Processor-Error'] = e.message
      errors << message
      nil
    end

    def process_attachment(name, content)
      raw_report = read_attachment(name, content)

      @reports.each do |klass|
        return klass.new(raw_report)
      rescue StandardError
        # ignore
      end

      raise 'Report not recognized'
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
