require 'bundler/setup'
require 'dotenv/load'
require 'googlepay'
require 'simplecov'
SimpleCov.start
require 'vcr'

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Googlepay.configure do |config|
      config.service_account = eval(ENV['SERVICE_ACCOUNT'])
    end
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = false
  c.default_cassette_options = {record: :new_episodes}
  c.configure_rspec_metadata!
  c.ignore_hosts 'codeclimate.com'
end