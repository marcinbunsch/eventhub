$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'eventhub'
require 'vcr'

VCR.config do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/fixtures'
  c.stub_with :webmock
end

