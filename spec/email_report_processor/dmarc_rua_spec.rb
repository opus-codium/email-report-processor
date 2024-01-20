# frozen_string_literal: true

require 'email_report_processor/dmarc_rua'

RSpec.describe EmailReportProcessor::DmarcRua do
  describe '#report' do
    subject(:processor) { described_class.new }

    let(:raw_report) { File.read('spec/fixtures/sample-reports/dmarc/google.com!example.com!1705363200!1705449599.xml') }

    it 'sends reports' do
      allow(processor).to receive(:send_report)
      processor.report(raw_report)
      expect(processor).to have_received(:send_report)
    end
  end
end
