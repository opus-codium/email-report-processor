# frozen_string_literal: true

require 'email_report_processor/processors/dmarc'
require 'email_report_processor/processors/tlsrpt'

module EmailReportProcessor
  class ReportProcessor
    attr_reader :errors

    def initialize(client:, options:)
      @dmarc_processor = Processors::Dmarc.new(client: client, options: options)
      @tlsrpt_processor = Processors::Tlsrpt.new(client: client, options: options)
    end

    def send_report(message)
      case message
      when Reports::Dmarc
        @dmarc_processor.send_report(message)
      when Reports::Tlsrpt
        @tlsrpt_processor.send_report(message)
      end
    end
  end
end
