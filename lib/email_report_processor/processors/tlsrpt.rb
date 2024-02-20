# frozen_string_literal: true

require 'email_report_processor/processors/base'

module EmailReportProcessor
  module Processors
    class Tlsrpt < Base
      DEFAULT_INDEX = 'tlsrpt-reports'

      def initialize(client:, options: {})
        @index_name = options[:tlsrpt_index] || DEFAULT_INDEX
        @pipeline = options[:tlsrpt_pipeline]
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
    end
  end
end
