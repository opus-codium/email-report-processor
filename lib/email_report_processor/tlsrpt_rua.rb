# frozen_string_literal: true

require 'email_report_processor/base'

require 'json'

module EmailReportProcessor
  class TlsrptRua < Base
    DEFAULT_INDEX = 'tlsrpt-reports'

    def initialize(client:, options: {})
      @index_name = options[:tlsrpt_index] || DEFAULT_INDEX
      super(client: client)
    end

    def index_mappings # rubocop:disable Metrics/MethodLength
      {
        properties: {
          'date-range': {
            properties: {
              'start-datetime': {
                type:   'date',
                format: 'date_time_no_millis',
              },
              'end-datetime':   {
                type:   'date',
                format: 'date_time_no_millis',
              },
            },
          },
        },
      }
    end

    def report(raw_report)
      report = JSON.parse(raw_report)

      report['policies'].each do |policy|
        report['policies'] = policy

        send_report(report)
      end
    end
  end
end
