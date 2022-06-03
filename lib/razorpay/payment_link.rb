require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Payment Links are URLs that you can send to your customers 
  # through SMS and email to collect payments from them.
  class PaymentLink < Entity
    def self.request
      Razorpay::Request.new('payment_links')
    end

    def self.create(options)
      request.create options
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.edit(id, options = {})
      request.patch id, options
    end

    def self.all(options = {})
      request.all options
    end

    def self.cancel(id)
      request.post "#{id}/cancel"
    end
    
    def self.notify_by(id,medium)
      request.post "#{id}/notify_by/#{medium}"
    end
  end
end
