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
    
    def self.createRecurringPayment(data={})
      request.post "create/recurring" , data
    end

    def self.createJsonPayment(data={})
      request.post "create/json" , data
    end

    def self.fetchPaymentDowntime
      request.get "downtimes"
    end

    def self.fetchPaymentDowntimeById(id)
      request.get "downtimes/#{id}"
    end

    def self.fetchCardDetails(id)
      request.get "#{id}/card"  
    end
    
    def fetchTransfer
      self.class.request.get "#{id}/transfers"  
    end

    def fetchRefund(refundId)
      self.class.request.get "#{id}/refunds/#{refundId}"  
    end
    
    def self.fetchMultipleRefund(id, options = {})
      request.get "#{id}/refunds",options
    end

    def transfer(options = {})
      self.class.request.post "#{id}/transfers", options
    end

    def self.edit(id, options = {})
      request.patch id, options
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
  end
end
