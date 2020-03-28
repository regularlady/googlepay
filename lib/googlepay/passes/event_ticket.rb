module Googlepay
  class EventTicketClass

    EVENT_URL = 'https://www.googleapis.com/walletobjects/v1/eventTicketClass'

    def initialize(parameters)
      @parameters = parameters
    end

    def create_class
      result = HTTParty.post("#{EVENT_URL}?access_token=#{fetch_google_token}",
                               :body => parameters.to_json,
                               :headers => { 'Content-Type' => 'application/json' } )

      update_class if result.try(:[], "error").try(:[], "code") == 409
    end

    def update_class
      HTTParty.put("#{EVENT_URL}/#{parameters[:id]}?access_token=#{fetch_google_token}",
                   :body => parameters.to_json,
                   :headers => { 'Content-Type' => 'application/json' } )
    end

    def create_object
      
    end   
  end  

end