require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Addon API allows you to fetch and delete
  # subscription-addons with Razorpay
  class Addon < Entity
    def fetch(id)
      request.fetch id
    end

    def create(subscription_id, options)
      # POST /addons is not supported
      # Addon creation endpoint is:
      # POST subscriptions/{sub_id}/addons
      request.request :post, "/subscriptions/#{subscription_id}/addons", options
    end
  end
end
