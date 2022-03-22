require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Addon API allows you to fetch and delete
  # subscription-addons with Razorpay
  class SubscriptionRegistration < Entity
    def self.request
      Razorpay::Request.new('subscription_registration/auth_links')
    end

    def self.create(options)
        request.create options
    end
  end
end
