# frozen_string_literal: true

require 'email_report_processor/base'

require 'webrick'
require 'webrick/https'

RSpec.describe EmailReportProcessor::Base do
  subject(:processor) { described_class.new(URI('https://localhost:9200/')) }

  before do
    allow(processor).to receive(:report)
    processor.process_attachment(attachment_name, content)
  end

  describe '#process_attachment' do
    let(:content) { File.read("spec/fixtures/sample-reports/dmarc/#{attachment_name}") }
    let(:expected_content) { File.read("spec/fixtures/sample-reports/dmarc/#{sample}") }

    context 'when given a gzipped file' do
      let(:attachment_name) { 'google.com!example.com!1705363200!1705449599.zip' }
      let(:sample) { "#{File.basename(attachment_name, '.zip')}.xml" }

      it { is_expected.to have_received(:report).with(expected_content) }
    end

    context 'when given a zipped file' do
      let(:attachment_name) { 'enterprise.protection.outlook.com!example.com!1704326400!1704412800.xml.gz' }
      let(:sample) { File.basename(attachment_name, '.gz') }

      it { is_expected.to have_received(:report).with(expected_content) }
    end
  end
end
