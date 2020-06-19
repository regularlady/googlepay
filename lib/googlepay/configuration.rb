module Googlepay
  class Configuration
    attr_accessor :service_account

    def initialize
      @service_account = nil
    end
  end
end