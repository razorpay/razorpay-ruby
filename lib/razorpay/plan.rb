require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Plan class handles all plan objects
  class Plan < Entity
    def self.request
      Razorpay::Request.new('plans')
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
  end
end
