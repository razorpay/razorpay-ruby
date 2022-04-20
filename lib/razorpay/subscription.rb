require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Subscription API allows you to create and
  # manage subscriptions with Razorpay
  class Subscription < Entity
    def create(options)
      request.create options
    end

    def fetch(id)
      request.fetch id
    end

    def all(options = {})
      request.all options
    end

    def cancel_with_id(id, options = {})
      request.post "#{id}/cancel", options
    end

    def cancel(options = {})
      cancel_with_id id, options
    end

    def cancel!(options = {})
      with_a_bang { cancel options }
    end
  end
end
