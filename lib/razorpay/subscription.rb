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

    def self.cancel(id, options = {})
      request.post "#{id}/cancel", options
    end

    def cancel(options = {})
      self.class.cancel id, options
    end

    def cancel!(options = {})
      with_a_bang { cancel options }
    end

    def edit(options = {})
      self.class.request.patch id, options
    end

    def pending_update
      self.class.request.get "#{id}/retrieve_scheduled_changes"
    end

    def self.cancel_scheduled_changes(id)
      request.post "#{id}/cancel_scheduled_changes"
    end

    def self.pause(id, options = {})
      request.post "#{id}/pause", options
    end

    def self.resume(id, options = {})
      request.post "#{id}/resume", options
    end

    def self.delete_offer(id, offerId)
      request.delete "#{id}/#{offerId}"
    end
  end
end
