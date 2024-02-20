# frozen_string_literal: true

require 'email_report_processor/processors/dmarc'
require 'email_report_processor/reports/dmarc'

require 'opensearch'

RSpec.describe EmailReportProcessor::Processors::Dmarc do
  subject(:processor) do
    described_class.new(client: client)
  end

  let(:client) { instance_double(OpenSearch::Client) }
  let(:report) { File.read('spec/fixtures/sample-reports/dmarc/enterprise.protection.outlook.com!blogreen.org!1706572800!1706659200.xml') }

  describe '#send_report' do
    before do
      allow(processor).to receive(:send_part)
      processor.send_report(EmailReportProcessor::Reports::Dmarc.new(report))
    end

    it { is_expected.to have_received(:send_part) }
  end

  describe '#send_part' do
    before do
      indices = instance_double(OpenSearch::API::Indices::Actions)
      allow(indices).to receive(:exists?).and_return(false)
      allow(indices).to receive(:create)
      allow(client).to receive(:indices).and_return(indices)
      allow(client).to receive(:index)
      processor.send_part(part)
    end

    let(:part) { double }

    it { expect(client).to have_received(:index).with({ index: 'dmarc-reports', body: part }) }
  end
end
