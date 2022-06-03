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
    
    def self.create_recurring_payment(data={})
      request.post "create/recurring" , data
    end

    def self.create_json_payment(data={})
      request.post "create/json" , data
    end

    def self.fetch_payment_downtime
      request.get "downtimes"
    end

    def self.fetch_payment_downtime_by_id(id)
      request.get "downtimes/#{id}"
    end

    def self.fetch_card_details(id)
      request.get "#{id}/card"  
    end
    
    def fetch_transfer
      self.class.request.get "#{id}/transfers"  
    end

    def fetch_refund(refundId)
      self.class.request.get "#{id}/refunds/#{refundId}"  
    end
    
    def self.fetch_multiple_refund(id, options = {})
      request.get "#{id}/refunds",options
    end

    def transfer(options = {})
      self.class.request.post "#{id}/transfers", options
    end

    def edit(options = {})
      self.class.request.patch id, options
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
