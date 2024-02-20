# frozen_string_literal: true

module EmailReportProcessor
  module Processors
    class Base
      attr_reader :index_name, :pipeline

      def initialize(client:)
        @client = client
        @index_exist = nil
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

      def send_report(report)
        report.parts.each do |part|
          send_part(part)
        end
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
