require 'razorpay/request'
require 'razorpay/refund'
require 'razorpay/entity'

module Razorpay
  # Payment Methods class is allows you to create
  # to fetch all payment methods
  class PaymentMethods < Entity
    def self.request
      Razorpay::Request.new('methods')
    end
    
    def self.all(options = {})
      request.all options
    end
  end
end
