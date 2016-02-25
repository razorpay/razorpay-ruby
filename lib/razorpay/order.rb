require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Order API is currently in beta and allows you to
  # associate Payments with an order entity
  class Order < Entity
    def self.request
      Razorpay::Request.new('orders')
    end

    def self.create(options)
      raise ArgumentError, 'Please provide order amount' unless options.key?(:amount)
      raise ArgumentError, 'Please provide order currency' unless options.key?(:currency)
      raise ArgumentError, 'Please provide order receipt' unless options.key?(:receipt)
      request.create options
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.all(options = {})
      request.all options
    end

    def payments(options = {})
      r = self.class.request
      r.request :get, "/orders/#{id}/payments", options
    end
  end
end
