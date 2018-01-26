require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Addon API allows you to fetch and delete
  # subscription-addons with Razorpay
  class Addon < Entity
    def self.request
      Razorpay::Request.new('addons')
    end

    def self.fetch(id)
      request.fetch id
    end
  end
end
