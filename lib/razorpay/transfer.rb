require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Refund class handles all refund objects
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

    def self.reverse(id, options)
      request.post "#{id}/reversals", options
    end
  end
end
