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

    def close
      self.class.request.patch id, status: 'closed'
    end

    def close!
      with_a_bang { close }
    end

    def payments(options = {})
      r = self.class.request
      r.request :get, "/virtual_accounts/#{id}/payments", options
    end
  end
end
