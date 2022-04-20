require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Customer API allows you to create and fetch customers on Razorpay
  class Customer < Entity
    def create(options)
      request.create options
    end

    def fetch(id)
      request.fetch id
    end

    def edit(id, options = {})
      request.put id, options
    end

    def all(options = {})
      request.all options
    end
  end
end
