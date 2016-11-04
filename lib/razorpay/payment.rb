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

    def self.capture_id(payment_id, options)
      raise ArgumentError, 'Please provide capture amount' unless options.key?(:amount)
      request.post "#{payment_id}/capture", options
    end

    def self.refund_id(payment_id, options = {})
      request.post "#{payment_id}/refund", options
    end

    def refund(options = {})
      self.class.refund_id(id, options)
    end

    def refunds
      # This needs to be a string, not a symbol
      Refund.new('payment_id' => id)
    end

    def capture(options)
      self.class.capture_id(id, options)
    end

    def method
      method_missing(:method)
    end

  end
end
