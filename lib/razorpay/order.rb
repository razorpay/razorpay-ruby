require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Order API allows you to associate
  # Payments with an order entity
  class Order < Entity
    def self.request
      Razorpay::Request.new('orders')
    end

    def self.create(options)
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
      r.request :get, "/v1/orders/#{id}/payments", options
    end
    
    def self.edit(id, options = {})
      request.patch id, options
    end
    
    def self.fetch_transfer_order(id)
      # Fetch Transfer for an Order
      # Docs: https://razorpay.com/docs/api/payments/route/#fetch-transfer-for-an-order
      request.get "#{id}/?expand[]=transfers&status"
    end

    def self.view_rto(id)
      request.post "#{id}/rto_review"
    end
    
    def self.edit_fulfillment(id, options = {})
      request.post "#{id}/fulfillment", options
    end
  end
end
