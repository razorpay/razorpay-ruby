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
       request.post "#{id}/close"
    end

    def close!
      with_a_bang { close }
    end

    def payments(options = {})
      r = self.class.request
      r.request :get, "/virtual_accounts/#{id}/payments", options
    end

    def self.add_receiver(id, options = {})
      request.post "#{id}/receivers", options
    end

    def self.allowed_payer(id, options = {})
      request.post "#{id}/allowed_payers", options
    end

    def self.delete_allowed_payer(id, payer_id)
      request.delete "#{id}/allowed_payers/#{payer_id}"
    end
  end
end
