require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Order API allows you to associate
  # Payments with an order entity
  class FundAccount < Entity
    def self.request
      Razorpay::Request.new('fund_accounts')
    end

    def self.create(options)
      request.create options
    end

    def self.fetch(id)
      request.fetch "?customer_id=#{id}"
    end
  end
end
