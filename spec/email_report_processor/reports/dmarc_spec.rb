# frozen_string_literal: true

require 'email_report_processor/reports/dmarc'

RSpec.describe EmailReportProcessor::Reports::Dmarc do
  subject(:report) do
    described_class.new(File.read('spec/fixtures/sample-reports/dmarc/enterprise.protection.outlook.com!blogreen.org!1706572800!1706659200.xml'))
  end

  describe '#report_id' do
    it { is_expected.to have_attributes(report_id: '76a4511632d34eb99e944bfa59537f71') }
  end

  describe '#parts' do
    subject { report.parts }

    it { is_expected.to have_attributes(length: 1) }
  end
end
