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

    def self.all(options = {})
       request.all options
    end

    def self.create(subscription_id, options)
      r = request
      # POST /addons is not supported
      # Addon creation endpoint is:
      # POST subscriptions/{sub_id}/addons
      r.request :post, "/subscriptions/#{subscription_id}/addons", options
    end
  end
end
