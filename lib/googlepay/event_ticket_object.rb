module Googlepay
  class EventTicketObject

    EVENT_URL = 'https://www.googleapis.com/walletobjects/v1/eventTicketObject?'

    def initialize(parameters)
      @parameters = parameters
    end

    def create
      rsa_private = OpenSSL::PKey::RSA.new Googlepay.configuration.service_account[:private_key]
      create_event_object(@parameters)
      payload = {
          "iss": Googlepay.configuration.service_account[:client_email],
          "aud": 'google',
          "typ": 'savetoandroidpay',
          "iat":  Time.now.utc.to_i,
          "payload": {
              'eventTicketObjects': [@parameters.dup.tap { |h| h.delete(:origin) }]
          },
          'origins': @parameters.fetch(:origin)
      }
      JWT.encode payload, rsa_private, 'RS256'
    end

  private

    def create_event_object(event_ticket)
      result = HTTParty.post("#{EVENT_URL}access_token=#{Googlepay.token}",
          :body => event_ticket.to_json,
          :headers => { 'Content-Type' => 'application/json' } )
    end
  end  

end