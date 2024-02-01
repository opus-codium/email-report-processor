# frozen_string_literal: true

require 'aruba/cucumber'

begin
  require 'rackup/handler/webrick'
rescue LoadError
  # XXX: Needed for Ruby 2.6 compatibility
  # Moved to the rackup gem in recent versions
  require 'rack/handler/webrick'
end
require 'sinatra/base'
require 'webrick'
require 'webrick/https'

class TestWebserver < Sinatra::Base
  get '/' do
    halt 200, { 'Content-Type' => 'application/json' }, <<~DATA
      {
        "name" : "example",
        "cluster_name" : "opensearch",
        "cluster_uuid" : "abcdefghijklmnopqrstuv",
        "version" : {
          "distribution" : "opensearch",
          "number" : "2.11.1",
          "build_type" : "deb",
          "build_hash" : "6b1986e964d440be9137eba1413015c31c5a7752",
          "build_date" : "2023-11-29T21:43:44.221253956Z",
          "build_snapshot" : false,
          "lucene_version" : "9.7.0",
          "minimum_wire_compatibility_version" : "7.10.0",
          "minimum_index_compatibility_version" : "7.0.0"
        },
        "tagline" : "The OpenSearch Project: https://opensearch.org/"
      }
    DATA
  end

  head '/dmarc-reports' do
    200
  end

  post '/dmarc-reports/_doc' do
    halt 201, { 'Content-Type' => 'application/json' }, <<~DATA
      {"_index": "dmarc-reports", "_id": "abcdefghijklmnopqrst", "_version": 1, "result": "created", "_shards": {"total": 2, "successful": 1, "failed": 0}, "_seq_no": 199, "_primary_term": 2}
    DATA
  end

  head '/tlsrpt-reports' do
    200
  end

  post '/tlsrpt-reports/_doc' do
    halt 201, { 'Content-Type' => 'application/json' }, <<~DATA
      {"_index": "tlsrpt-reports", "_id": "abcdefghijklmnopqrst", "_version": 1, "result": "created", "_shards": {"total": 2, "successful": 1, "failed": 0}, "_seq_no": 28, "_primary_term": 2}
    DATA
  end
end

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
  $server.mount('/', Rack::Handler::WEBrick, TestWebserver)
  Thread.new { $server.start }
  Timeout.timeout(1) { sleep(0.1) until started }
end

AfterAll do
  $server&.shutdown
end
# rubocop:enable Style/GlobalVars
