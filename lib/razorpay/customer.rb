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
  end
end
