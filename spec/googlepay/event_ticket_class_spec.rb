require 'pry'

RSpec.describe Googlepay::EventTicketClass do

  before(:each) do
    @parameters = {
      "kind": "walletobjects#eventTicketClass",
      "id": "3388000000002437969.123456789",
      "reviewStatus": "underReview",
      "issuerName": "Your Company Name",
      "eventName": {
        "kind": "walletobjects#localizedString",
          "translatedValues": [   {
            "kind": "walletobjects#translatedString",
              "language": "en-US",
              "value": "Your Event Title"
        }],
          "defaultValue": {
            "kind": "walletobjects#translatedString",
                "language": "en-US",
                "value": "Ticket"
        }
      }
    }
  end

  describe '#new' do
    it 'works' do
      parameters = @parameters
      result = Googlepay::EventTicketClass.new(parameters)
      expect(result.class).to eq(Googlepay::EventTicketClass)
    end
  end

  describe '#create' do
    it 'works', vcr: {cassette_name: :create_event_ticket_class} do
      parameters = @parameters
      event_ticket_class = Googlepay::EventTicketClass.new(parameters)
      result = event_ticket_class.create
      expect(result["kind"]).to eq("walletobjects#eventTicketClass")
      expect(result.code).to eq(200)
    end
  end

  describe '#update' do
    it 'works', vcr: {cassette_name: :update_event_ticket_class} do
      parameters = @parameters
      @parameters[:eventName][:defaultValue][:value] = 'Updated Ticket'
      event_ticket_class = Googlepay::EventTicketClass.new(parameters)
      result = event_ticket_class.update
      expect(result['eventName']['defaultValue']['value']).to eq('Updated Ticket')
      expect(result.code).to eq(200)
    end
  end

end
