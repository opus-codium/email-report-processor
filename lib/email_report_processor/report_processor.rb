# frozen_string_literal: true

class ReportProcessor
  attr_reader :errors

  def initialize(client:, options:)
    @processors = [
      EmailReportProcessor::DmarcRua.new(client: client, options: options),
      EmailReportProcessor::TlsrptRua.new(client: client, options: options),
    ]
    @errors = []
  end

  def process_message(mail)
    processed = false

    @processors.each do |processor|
      processed ||= processor.process_message(mail)
    rescue RuntimeError
      # ignore
    end

    @errors << mail unless processed
  end
end
