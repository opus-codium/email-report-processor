# frozen_string_literal: true

require 'mail'

module EmailReportProcessor
  class Mbox
    def initialize(filename)
      @io = File.open(filename, 'rb')
      @current_message = ''
      @last_line = ''
    end

    def next_message
      read_message || last_message
    end

    def read_message
      while (line = @io.gets)
        if new_message?(line)
          return generate_mail_from_current_message unless @current_message.empty?
        else
          add_line_to_current_message(line)
        end
        @last_line = line.chomp
      end

      nil
    end

    def last_message
      generate_mail_from_current_message
    end

    def new_message?(line)
      line.start_with?('From ') && @last_line.empty?
    end

    def add_line_to_current_message(line)
      @current_message += if line.start_with?('>From ')
                            line[1..]
                          else
                            line
                          end
    end

    def generate_mail_from_current_message
      return nil if @current_message.empty?

      @current_message.force_encoding('UTF-8')
      @current_message.force_encoding('ISO-8859-1') unless @current_message.valid_encoding?
      raise 'Encoding issue' unless @current_message.valid_encoding?

      mail = Mail.new(@current_message)
      @current_message = ''
      mail
    end
  end
end
