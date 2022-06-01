require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # SubscriptionRegistration are an alternate way of 
  # creating an authorization transaction
  class SubscriptionRegistration < Entity
    def self.request
      Razorpay::Request.new('subscription_registration/auth_links')
    end

    def self.create(options)
        request.create options
    end
  end
end
