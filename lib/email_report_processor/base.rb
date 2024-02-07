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
      @index_exist = nil
    end

    def report(_report)
      raise 'Should not be called. Override this method and call #send_report'
    end

    def send_report(report)
      create_index unless index_exist?

      @client.index(index: index_name, body: report)
    end

    def index_exist?
      @index_exist ||= @client.indices.exists?(index: index_name)
    end

    def create_index
      @client.indices.create(
        index: index_name,
        body:  {
          mappings: index_mappings,
        },
      )
    end

    def process_message(mail)
      part = mail.attachments.first || mail
      content_disposition = part['Content-Disposition']
      return nil unless content_disposition

      filename = content_disposition.filename

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
