require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Virtual Account API allows you to create and
  # manage virtual accounts with Razorpay
  class VirtualAccount < Entity
    def self.request
      Razorpay::Request.new('virtual_accounts')
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

    def self.close(id)
      request.patch id, status: 'closed'
    end
  end
end
