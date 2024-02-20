# frozen_string_literal: true

module EmailReportProcessor
  module Reports
    class Dmarc
      class Record
        def initialize(record)
          @record = record
          flatten_dkim_auth_results!
        end

        def flatten_dkim_auth_results!
          return unless @record['auth_results']['dkim']

          @record['auth_results']['dkim'] = [@record['auth_results']['dkim']].flatten.each_with_index.to_a.to_h(&:reverse)
        end

        def to_h
          @record
        end
      end
    end
  end
end
