# frozen_string_literal: true

require 'email_report_processor/message_reader'

require 'mail'

RSpec.describe EmailReportProcessor::MessageReader do
  describe '#process_message' do
    subject { described_class.new.process_message(message) }

    context 'when given a DMARC Report' do
      let(:message) { Mail.new(File.read('spec/fixtures/sample-reports/dmarc/report.elm')) }

      it { is_expected.to be_a(EmailReportProcessor::Reports::Dmarc) }
    end

    context 'when given a SMTP TLS Report' do
      let(:message) { Mail.new(File.read('spec/fixtures/sample-reports/tlsrpt/report.elm')) }

      it { is_expected.to be_a(EmailReportProcessor::Reports::Tlsrpt) }
    end
  end

  describe '#read_attachment' do
    subject { described_class.new.read_attachment(attachment_name, content) }

    let(:content) { File.read("spec/fixtures/sample-reports/dmarc/#{attachment_name}") }
    let(:expected_content) { File.read("spec/fixtures/sample-reports/dmarc/#{sample}") }

    context 'when given a gzipped file' do
      let(:attachment_name) { 'google.com!example.com!1705363200!1705449599.zip' }
      let(:sample) { "#{File.basename(attachment_name, '.zip')}.xml" }

      it { is_expected.to eq(expected_content) }
    end

    context 'when given a zipped file' do
      let(:attachment_name) { 'enterprise.protection.outlook.com!example.com!1704326400!1704412800.xml.gz' }
      let(:sample) { File.basename(attachment_name, '.gz') }

      it { is_expected.to eq(expected_content) }
    end
  end
end
