
RSpec.describe Googlepay::EventTicketObject do

  before(:each) do
    @parameters = {
      "classId": "3388000000002437969.123456789",
      "id": "3388000000002437969.23456",
      "state": "active", 
      "origin": "https://brittanymartin.dev"   
    }
  end

  describe '#new' do
    it 'works' do
      parameters = @parameters
      result = Googlepay::EventTicketObject.new(parameters)
      expect(result.class).to eq(Googlepay::EventTicketObject)
    end
  end

  describe '#create' do
    it 'works', vcr: {cassette_name: :create_event_ticket_object} do
      event_ticket_object = Googlepay::EventTicketObject.new(@parameters)
      result = event_ticket_object.create
      expect(result.class).to be(String)
    end
  end

end
