# frozen_string_literal: true

require 'email_report_processor/processors/base'

module EmailReportProcessor
  module Processors
    class Dmarc < Base
      DEFAULT_INDEX = 'dmarc-reports'

      def initialize(client:, options: {})
        @index_name = options[:dmarc_index] || DEFAULT_INDEX
        @pipeline = options[:dmarc_pipeline]

        @date_range_field = 'feedback.report_metadata.date_range.begin'
        @report_id_field = 'feedback.report_metadata.report_id'
        super
      end

      def index_mappings # rubocop:disable Metrics/MethodLength
        {
          properties: {
            feedback: {
              properties: {
                report_metadata:  {
                  properties: {
                    date_range: {
                      properties: {
                        begin: {
                          type:   'date',
                          format: 'epoch_second',
                        },
                        end:   {
                          type:   'date',
                          format: 'epoch_second',
                        },
                      },
                    },
                  },
                },
                policy_published: {
                  properties: {
                    pct: {
                      type: 'integer',
                    },
                  },
                },
                record:           {
                  properties: {
                    row: {
                      properties: {
                        source_ip: {
                          type: 'ip',
                        },
                        count:     {
                          type: 'integer',
                        },
                      },
                    },
                  },
                },
              },
            },
          },
        }
      end
    end
  end
end
