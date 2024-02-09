# frozen_string_literal: true

require 'email_report_processor/dmarc_rua'

RSpec.describe EmailReportProcessor::DmarcRua do
  subject(:processor) { described_class.new(client: client) }

  let(:client) { double }

  describe '#process_message' do
    let(:mail) { Mail.new(File.read('spec/fixtures/sample-reports/dmarc/report.elm')) }

    it 'sends reports' do
      allow(processor).to receive(:send_report)
      processor.process_message(mail)
      expect(processor).to have_received(:send_report)
    end
  end

  describe '#report' do
    let(:raw_report) { File.read('spec/fixtures/sample-reports/dmarc/google.com!example.com!1705363200!1705449599.xml') }

    before do
      allow(processor).to receive(:send_report)
      processor.report(raw_report)
    end

    it 'sends reports' do
      expect(processor).to have_received(:send_report)
    end

    context 'without DKIM' do
      let(:raw_report) { File.read('spec/fixtures/sample-reports/dmarc/enterprise.protection.outlook.com!blogreen.org!1706572800!1706659200.xml') }

      it 'does not include DKIM auth_results' do
        expect(processor).to have_received(:send_report)
          .with(hash_including('feedback' => hash_including('record' => hash_including('auth_results' => hash_not_including('dkim')))))
      end
    end
  end
end
