# frozen_string_literal: true

require 'aruba/cucumber'

require 'webrick'
require 'webrick/https'

# rubocop:disable Style/GlobalVars
BeforeAll do
  started = false
  server_options = {
    Port:          9200,
    StartCallback: -> { started = true },
    AccessLog:     [],
    Logger:        WEBrick::Log.new(File.open(File::NULL, 'w')),
    SSLEnable:     true,
    SSLCertName:   [%w[CN localhost]],
  }
  $server = WEBrick::HTTPServer.new(server_options)
  Thread.new { $server.start }
  Timeout.timeout(1) { sleep(0.1) until started }
  puts 'go'
end

AfterAll do
  $server&.shutdown
end
# rubocop:enable Style/GlobalVars
