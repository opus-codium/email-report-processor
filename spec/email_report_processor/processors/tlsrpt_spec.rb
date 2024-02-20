# frozen_string_literal: true

require 'email_report_processor/processors/tlsrpt'
require 'email_report_processor/reports/tlsrpt'

require 'opensearch'

RSpec.describe EmailReportProcessor::Processors::Tlsrpt do
  subject(:processor) do
    described_class.new(client: client)
  end

  let(:client) { instance_double(OpenSearch::Client) }
  let(:report) { File.read('spec/fixtures/sample-reports/tlsrpt/google.com!example.com!1667520000!1667606399!001.json') }

  describe '#send_report' do
    before do
      allow(processor).to receive(:send_part)
      processor.send_report(EmailReportProcessor::Reports::Tlsrpt.new(report))
    end

    it { is_expected.to have_received(:send_part) }
  end
end
