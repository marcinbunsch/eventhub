$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'eventhub'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.stub_with :webmock
end

