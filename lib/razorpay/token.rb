require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  
  class Token < Entity

    def self.request
      Razorpay::Request.new('tokens')
    end

    def self.create(options)
      request.create options
    end

    def self.fetch(options)
      request.post "fetch", options
    end 

    def self.delete(options)
      request.post "delete", options
    end

    def self.process_payment_on_alternate_pa_or_pg(options)
      request.post "service_provider_tokens/token_transactional_data", options
    end
  end
end