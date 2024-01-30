# frozen_string_literal: true

require 'email_report_processor/tlsrpt_rua'

RSpec.describe EmailReportProcessor::TlsrptRua do
  subject(:processor) { described_class.new(client: client) }

  let(:client) { double }

  describe '#process_message' do
    let(:mail) { Mail.new(File.read('spec/fixtures/sample-reports/tlsrpt/report.elm')) }

    it 'sends reports' do
      allow(processor).to receive(:send_report)
      processor.process_message(mail)
      expect(processor).to have_received(:send_report)
    end
  end

  describe '#report' do
    let(:raw_report) { File.read('spec/fixtures/sample-reports/tlsrpt/google.com!example.com!1667520000!1667606399!001.json') }

    it 'sends reports' do
      allow(processor).to receive(:send_report)
      processor.report(raw_report)
      expect(processor).to have_received(:send_report)
    end
  end
end
