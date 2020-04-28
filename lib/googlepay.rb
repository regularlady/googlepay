require 'googleauth'
require 'httparty'
require 'pry'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Googlepay

  SCOPE = 'https://www.googleapis.com/auth/wallet_object.issuer'

  def self.token
    fetch_token
  end

  private
 
  def self.fetch_token
    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open("#{root}/gpay.json"),
      scope: SCOPE
    )
  
    authorizer.fetch_access_token!['access_token']
  end

  def self.root
    File.expand_path '../..', __FILE__
  end

end