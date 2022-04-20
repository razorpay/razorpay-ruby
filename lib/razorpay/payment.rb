require 'razorpay/request'
require 'razorpay/refund'
require 'razorpay/entity'

module Razorpay
  # Payment class is the most commonly used class
  # and is used to interact with Payments, the most
  # common type of transactions
  class Payment < Entity
    def fetch(id)
      request.fetch id
    end

    def all(options = {})
      request.all options
    end

    def capture_with_id(id, options)
      request.post "#{id}/capture", options
    end

    def refund(options = {})
      request.post "#{id}/refund", options
    end

    def refund!(options = {})
      refund = refund options
      with_a_bang { self.class.request.fetch id }
      refund
    end

    def capture(options)
      request.post "#{id}/capture", options
    end

    def capture!(options)
      with_a_bang { capture options }
    end

    def refunds
      request.get "#{id}/refunds"
    end

    def method
      method_missing(:method)
    end

    def bank_transfer
      request.get "#{id}/bank_transfer"
    end
  end
end
