require 'googleauth'
require 'httparty'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Googlepay

  SCOPE = 'https://www.googleapis.com/auth/wallet_object.issuer'

  def self.token
    fetch_token
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  private
 
  def self.fetch_token
    json_key = Tempfile.new
    json_key.write(Googlepay.configuration.service_account.to_json)
    json_key.rewind
    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: json_key,
      scope: SCOPE
    )
    json_key.close
    authorizer.fetch_access_token!['access_token']
  end

  def self.root
    File.expand_path '../..', __FILE__
  end

end