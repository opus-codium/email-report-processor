# frozen_string_literal: true

require 'mail'

module EmailReportProcessor
  class MailDir
    def initialize(filename)
      @messages = Dir["#{filename}/cur/*"]
    end

    def next_message
      mail = @messages.pop
      Mail.new(File.read(mail)) if mail
    end
  end
end
