# frozen_string_literal: true

require 'email_report_processor/base'

require 'json'

module EmailReportProcessor
  class TlsrptRua < Base
    def initialize
      super(URI('https://admin:admin@localhost:9200/tls-reports/_doc'))
    end

    def report(raw_report)
      report = JSON.parse(raw_report)

      report['policies'].each do |policy|
        report['policies'] = policy

        send_report(report.to_json)
      end
    end
  end
end
