require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Subscription class handles all subscription objects
  class Subscription < Entity
    def self.request
      Razorpay::Request.new('subscriptions')
    end

    def self.create(options)
      request.create options
    end

    def self.all(options = {})
      request.all options
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.cancel(id, options={})
      request.post "#{id}/cancel", options
    end
  end
end
