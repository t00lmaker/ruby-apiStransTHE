require 'webmock'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true

  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end
