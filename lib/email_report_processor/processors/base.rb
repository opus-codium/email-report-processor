# frozen_string_literal: true

module EmailReportProcessor
  module Processors
    class Base
      attr_reader :index_name, :pipeline

      def initialize(client:, options:)
        @client = client
        @index_exist = nil
        @options = options
      end

      def index_exist?
        if @index_exist.nil?
          @index_exist ||= @client.indices.exists?(index: index_name)
        else
          @index_exist
        end
      end

      def create_index
        @client.indices.create(
          index: index_name,
          body:  {
            mappings: index_mappings,
          },
        )
        @index_exist = true
      end

      def known_report_ids
        @known_report_ids ||= _known_report_ids
      end

      # rubocop:disable Metrics/MethodLength
      def _known_report_ids
        return [] unless index_exist?

        query = {
          size:  0,
          query: {
            range: {
              @date_range_field => {
                gte: @options[:deduplicate_since],
                lte: @options[:deduplicate_until],
              },
            },
          },
          aggs:  {
            report_ids: {
              terms: {
                field: "#{@report_id_field}.keyword",
                size:  @options[:deduplicate_count],
              },
            },
          },
        }

        res = @client.search(index: index_name, body: query)

        missed = res['aggregations']['report_ids']['sum_other_doc_count']

        raise "Current deduplication settings would miss #{missed} documents. Aborting." unless missed.zero?

        res['aggregations']['report_ids']['buckets'].map { |bucket| bucket['key'] }
      end
      # rubocop:enable Metrics/MethodLength

      def send_report(report)
        return if known_report_ids.include?(report.report_id)

        report.parts.each do |part|
          send_part(part)
        end

        known_report_ids << report.report_id
      end

      def send_part(part)
        create_index unless index_exist?

        params = { index: index_name, body: part }
        params[:pipeline] = pipeline if pipeline

        @client.index(params)
      end
    end
  end
end
