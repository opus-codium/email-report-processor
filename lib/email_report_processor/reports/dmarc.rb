# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/hash'

require 'email_report_processor/reports/dmarc/record'

module EmailReportProcessor
  module Reports
    class Dmarc
      def initialize(raw_report)
        @report = Hash.from_xml(raw_report)

        @report['feedback'].delete('xmlns:xsd')
        @report['feedback'].delete('xmlns:xsi')

        @records = [@report['feedback'].delete('record')].flatten.map { |record| Dmarc::Record.new(record) }
      end

      def parts
        @records.map do |record|
          report = Marshal.load(Marshal.dump(@report))
          report['feedback']['record'] = record.to_h
          report
        end
      end
    end
  end
end
