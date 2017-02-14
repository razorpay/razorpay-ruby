require 'razorpay/request'
require 'razorpay/refund'
require 'razorpay/entity'

module Razorpay
  # Payment class is the most commonly used class
  # and is used to interact with Payments, the most
  # common type of transactions
  class Payment < Entity
    def self.request
      Razorpay::Request.new('payments')
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.all(options = {})
      request.all options
    end

    def self.capture(id, options)
      request.post "#{id}/capture", options
    end

    def refund(options = {})
      self.class.request.post "#{id}/refund", options
    end

    def capture(options)
      self.class.request.post "#{id}/capture", options
    end

    def refunds
      self.class.request.request :get, "payments/#{id}/refunds"
    end

    def method
      method_missing(:method)
    end
  end
end
