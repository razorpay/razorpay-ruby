require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Refund class handles all refund objects
  class Refund < Entity
    def create(options)
      request.create options
    end

    def all(options = {})
      request.all options
    end

    def fetch(id)
      request.fetch id
    end
  end
end
