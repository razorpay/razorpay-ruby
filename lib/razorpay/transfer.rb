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
      request.fetch "#{id}"
    end

    def self.edit(id, options = {})
      request.patch id, options
    end

    def self.reverse(id, options = {})
      request.post "#{id}/reversals", options
    end

    def self.fetchSettlements
      request.get "?expand[]=recipient_settlement"
    end
  end
end
