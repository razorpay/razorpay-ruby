require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Virtual Account API allows you to create and
  # manage virtual accounts with Razorpay
  class VirtualAccount < Entity
    def create(options)
      request.create options
    end

    def fetch(id)
      request.fetch id
    end

    def all(options = {})
      request.all options
    end

    def close_with_id(id)
      request.patch id, status: 'closed'
    end

    def close
      request.patch id, status: 'closed'
    end

    def close!
      with_a_bang { close }
    end

    def payments(options = {})
      request.request :get, "/virtual_accounts/#{id}/payments", options
    end
  end
end
