# frozen_string_literal: true

require 'email_report_processor/reports/tlsrpt'

RSpec.describe EmailReportProcessor::Reports::Tlsrpt do
  subject(:report) do
    described_class.new(File.read('spec/fixtures/sample-reports/tlsrpt/google.com!example.com!1667520000!1667606399!001.json'))
  end

  describe '#parts' do
    subject { report.parts }

    it { is_expected.to have_attributes(length: 1) }
  end
end
