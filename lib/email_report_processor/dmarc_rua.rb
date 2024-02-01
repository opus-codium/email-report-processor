# frozen_string_literal: true

require 'email_report_processor/base'

require 'active_support'
require 'active_support/core_ext/hash'
require 'json'

module EmailReportProcessor
  class DmarcRua < Base
    DEFAULT_INDEX = 'dmarc-reports'

    def initialize(client:, options: {})
      @index_name = options[:dmarc_index] || DEFAULT_INDEX
      super(client: client)
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

    def report(raw_report)
      report = Hash.from_xml(raw_report)

      report_records(report).each do |record|
        record['auth_results']['dkim'] = [record['auth_results']['dkim']].flatten.each_with_index.to_a.to_h(&:reverse)
        report['feedback']['record'] = record

        send_report(report)
      end
    end

    def report_records(report)
      [report['feedback']['record']].flatten.map(&:to_h)
    end
  end
end
