# frozen_string_literal: true

require 'email_report_processor/base'

require 'active_support'
require 'active_support/core_ext/hash'
require 'json'

module EmailReportProcessor
  class DmarcRua < Base
    DEFAULT_INDEX = 'dmarc-reports'

    def initialize(**options)
      @index_name = options[:dmarc_endpoint] || DEFAULT_INDEX
      super(client: options[:client])
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
