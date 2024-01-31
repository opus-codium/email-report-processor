# frozen_string_literal: true

class ReportProcessor
  def initialize(client:, options:)
    @processors = [
      EmailReportProcessor::DmarcRua.new(client: client, options: options),
      EmailReportProcessor::TlsrptRua.new(client: client, options: options),
    ]
  end

  def process_message(mail)
    processed = false

    @processors.each do |processor|
      processor.process_message(mail)
      processed = true
    rescue REXML::ParseException, JSON::ParserError
      # ignore
    end

    return if processed

    raise "No processor for report with Message-Id #{mail.message_id}"
  end
end
