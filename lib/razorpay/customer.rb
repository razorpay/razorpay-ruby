require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Customer API allows you to create customer IDs on Razorpay
  class Customer < Entity
    def self.request
      Razorpay::Request.new('customers')
    end

    def self.create(options)
      request.create options
    end
  end
end
