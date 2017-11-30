require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Plan API allows you to create and
  # manage subscription-plans with Razorpay
  class Plan < Entity
    def self.request
      Razorpay::Request.new('plans')
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
  end
end
