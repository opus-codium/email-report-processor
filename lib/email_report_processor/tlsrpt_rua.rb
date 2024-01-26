# frozen_string_literal: true

require 'email_report_processor/base'

require 'json'

module EmailReportProcessor
  class TlsrptRua < Base
    DEFAULT_ENDPOINT = '/tlsrpt-reports'

    def initialize(**options)
      super(**options, endpoint: options[:tlsrpt_endpoint] || DEFAULT_ENDPOINT)
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
