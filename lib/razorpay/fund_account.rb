require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # FundAccount API allows you to create and fetch a fund account for a customer. 
  class FundAccount < Entity
    def self.request
      Razorpay::Request.new('fund_accounts')
    end

    def self.create(options)
      request.create options
    end

    def self.all(data = {})
      request.all data
    end
  end
end
