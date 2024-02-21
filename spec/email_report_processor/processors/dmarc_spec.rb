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
      allow(processor).to receive(:known_report_ids).and_return(known_report_ids)
      processor.send_report(EmailReportProcessor::Reports::Dmarc.new(report))
    end

    context 'when the report does not already exist' do
      let(:known_report_ids) { [] }

      it { expect(processor).to have_received(:send_part) }
    end

    context 'when the report already exist' do
      let(:known_report_ids) { ['76a4511632d34eb99e944bfa59537f71'] }

      it { expect(processor).not_to have_received(:send_part) }
    end
  end

  describe '#send_part' do
    before do
      indices = instance_double(OpenSearch::API::Indices::Actions)
      allow(indices).to receive(:exists?).and_return(true)
      allow(client).to receive(:indices).and_return(indices)
      allow(client).to receive(:index)
      processor.send_part(part)
    end

    let(:part) { double }

    it { expect(client).to have_received(:index).with({ index: 'dmarc-reports', body: part }) }
  end

  describe '#known_report_ids' do
    before do
      indices = instance_double(OpenSearch::API::Indices::Actions)
      allow(indices).to receive(:exists?).and_return(true)
      allow(client).to receive_messages(indices: indices, search: { 'aggregations' => { 'report_ids' => { 'buckets' => [], 'sum_other_doc_count' => 0 } } })
      processor.known_report_ids
    end

    it { expect(client).to have_received(:search) }
  end
end
