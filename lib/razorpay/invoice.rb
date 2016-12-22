require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Invoice API allows you to create and
  # manage invoices with Razorpay
  class Invoice < Entity
    def self.request
      Razorpay::Request.new('invoices')
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
