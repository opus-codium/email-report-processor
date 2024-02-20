# frozen_string_literal: true

require 'email_report_processor/report_processor'
require 'email_report_processor/reports/dmarc'
require 'email_report_processor/reports/tlsrpt'

RSpec.describe EmailReportProcessor::ReportProcessor do
  describe '#send_report' do
    subject(:processor) { described_class.new(client: nil, options: {}) }

    let(:dmarc_processor) { instance_double(EmailReportProcessor::Processors::Dmarc) }
    let(:tlsrpt_processor) { instance_double(EmailReportProcessor::Processors::Tlsrpt) }

    before do
      allow(EmailReportProcessor::Processors::Dmarc).to receive(:new).and_return(dmarc_processor)
      allow(EmailReportProcessor::Processors::Tlsrpt).to receive(:new).and_return(tlsrpt_processor)

      allow(dmarc_processor).to receive(:send_report)
      allow(tlsrpt_processor).to receive(:send_report)

      processor.send_report(message)
    end

    context 'when given a DMARC Report' do
      let(:message) do
        mail = File.read('spec/fixtures/sample-reports/dmarc/google.com!example.com!1705363200!1705449599.xml')
        EmailReportProcessor::Reports::Dmarc.new(mail)
      end

      it { expect(dmarc_processor).to have_received(:send_report).with(message) }
    end

    context 'when given a SMTP TLS Report' do
      let(:message) do
        mail = File.read('spec/fixtures/sample-reports/tlsrpt/google.com!example.com!1667520000!1667606399!001.json')
        EmailReportProcessor::Reports::Tlsrpt.new(mail)
      end

      it { expect(tlsrpt_processor).to have_received(:send_report).with(message) }
    end
  end
end
