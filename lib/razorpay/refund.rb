require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Refund class handles all refund objects
  class Refund < Entity
    def self.request
      Razorpay::Request.new('refunds')
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
  end
end
