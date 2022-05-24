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

    def refund!(options = {})
      refund = refund options
      with_a_bang { self.class.request.fetch id }
      refund
    end

    def capture(options)
      self.class.request.post "#{id}/capture", options
    end

    def capture!(options)
      with_a_bang { capture options }
    end

    def refunds
      self.class.request.get "#{id}/refunds"
    end

    def method
      method_missing(:method)
    end

    def bank_transfer
      self.class.request.get "#{id}/bank_transfer"
    end

    def self.otp_generate(id)
      request.post "#{id}/otp_generate"
    end

    def otp_submit(options)
      self.class.request.post "#{id}/otp/submit", options
    end

    def otp_resend
      self.class.request.post "#{id}/otp/resend"
    end
  end
end
