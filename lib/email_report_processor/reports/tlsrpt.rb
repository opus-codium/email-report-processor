# frozen_string_literal: true

require 'json'

module EmailReportProcessor
  module Reports
    class Tlsrpt
      def initialize(raw_report)
        @report = JSON.parse(raw_report)
        @policies = @report.delete('policies')
      end

      def report_id
        @report['report-id']
      end

      def parts
        @policies.map do |policy|
          @report.merge({ 'policies' => policy })
        end
      end
    end
  end
end
