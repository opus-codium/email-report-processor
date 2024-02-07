# frozen_string_literal: true

require 'email_report_processor/mbox'

RSpec.describe EmailReportProcessor::MBox do
  subject(:mbox) { described_class.new('spec/fixtures/mbox/romain') }

  describe '#next' do
    context 'when reading all messages' do
      let(:message_count) do
        n = 0
        n += 1 while mbox.next_message
        n
      end

      it { expect(message_count).to eq(10) }
    end
  end
end
