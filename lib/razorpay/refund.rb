require 'razorpay'
require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Refund class handles all refund objects
  class Refund < Entity
    def initialize(data)
      super
      @request = Razorpay::Request.new("payments/#{payment_id}/refunds")
    end

    def all(options = {})
      # We receive an array of item hashes
      @request.all options
    end

    def fetch(id)
      @request.fetch id
    end
  end
end
