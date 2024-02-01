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

      report['feedback']['record'] = [report['feedback']['record']] unless report['feedback']['record'].is_a?(Array)

      report['feedback']['record'].each do |record|
        report['feedback']['record'] = record.to_h

        send_report(report)
      end
    end
  end
end
