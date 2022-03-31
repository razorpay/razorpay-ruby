require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Customer API allows you to create and fetch customers on Razorpay
  class Customer < Entity
    def self.request
      Razorpay::Request.new('customers')
    end

    def self.create(options)
      request.create options
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.edit(id, options = {})
      request.put id, options
    end

    def self.all(options = {})
      request.all options
    end
    
    # Fetch token by customerId
    # https://razorpay.com/docs/api/recurring-payments/upi/tokens/#22-fetch-tokens-by-customer-id 
    def fetchTokens
      self.class.request.get "#{id}/tokens" 
    end
 
   # Fetch specific token 
    def fetchToken(tokenId)
      self.class.request.get "#{id}/tokens/#{tokenId}" 
    end

    def deleteToken(tokenId)
      self.class.request.delete "#{id}/tokens/#{tokenId}" 
    end
  end
end
