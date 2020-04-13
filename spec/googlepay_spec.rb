RSpec.describe Googlepay do
  it "has a version number" do
    expect(Googlepay::VERSION).not_to be nil
  end

  it "fetches an authentication token", vcr: {cassette_name: :fetch_token} do
    result = Googlepay.fetch_token
    expect(result.class).to eq(String)
    expect(result).to include('ya29.')
  end
end
