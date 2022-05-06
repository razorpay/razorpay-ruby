require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Transfer class handles all refund objects
  class Transfer < Entity
    def self.request
      Razorpay::Request.new('transfers')
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

    def edit(options = {})
      self.class.request.patch id, options
    end

    def reverse(options = {})
      self.class.request.post "#{id}/reversals", options
    end

    def self.fetch_settlements
      request.get "?expand[]=recipient_settlement"
    end
  end
end
