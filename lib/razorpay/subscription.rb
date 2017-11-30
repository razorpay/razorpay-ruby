require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Subscription API allows you to create and
  # manage subscriptions with Razorpay
  class Subscription < Entity
    def self.request
      Razorpay::Request.new('subscriptions')
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

    def self.cancel(id)
      request.post "#{id}/cancel"
    end

    def self.addons(id, addons)
      request.post "#{id}/addons", addons
    end

    def cancel
      self.class.cancel(id)
    end
  end
end
