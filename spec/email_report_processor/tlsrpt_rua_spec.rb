# frozen_string_literal: true

require 'email_report_processor/tlsrpt_rua'

RSpec.describe EmailReportProcessor::TlsrptRua do
  describe '#report' do
    subject(:processor) { described_class.new }

    let(:raw_report) { File.read('google.com!blogreen.org!1667520000!1667606399!001.json') }

    it 'sends reports' do
      allow(processor).to receive(:send_report)
      processor.report(raw_report)
      expect(processor).to have_received(:send_report)
    end
  end
end
