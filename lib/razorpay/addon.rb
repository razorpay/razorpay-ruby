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

    # request.post "/subscriptions/#{subscription_id}/addons", options
    ## results in wrong url /v1/addons//subscriptions/sub_9UIyKhqF0C64AM/addons
    def self.create(subscription_id, options)
      r = request
      r.request :post, "/subscriptions/#{subscription_id}/addons", options
    end
  end
end
