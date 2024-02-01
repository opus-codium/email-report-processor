# frozen_string_literal: true

require 'strscan'

module EmailReportProcessor
  class MailBox
    def initialize(filename)
      @scanner = StringScanner.new(File.read(filename))
    end

    # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity
    def next_message
      message = ''

      until @scanner.eos?
        if @scanner.scan(/From .*\n/)
          # Ignore
        elsif @scanner.scan("\nFrom ")
          @scanner.unscan
          @scanner.getch
          return Mail.new(message)
        elsif @scanner.scan(/>From.*\n/)
          message += @scanner.matched[1..]
        elsif @scanner.scan(/.*\n/)
          message += @scanner.matched
        end
      end

      if message.empty?
        nil
      else
        Mail.new(message)
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/PerceivedComplexity
  end
end
