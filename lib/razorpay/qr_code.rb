require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # QrCode API allows you to create, close and fetch QR codes
  class QrCode < Entity
    def self.request
      Razorpay::Request.new('payments/qr_codes')
    end

    def self.create(options)
        if(!options.is_a?(String) && options.key?(:fixed_amount))
           options[:fixed_amount] = (options[:fixed_amount] ? 1 : 0)
        end  
      request.create options
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.all(options = {})
      request.all options
    end

    def fetch_payments(options = {})
      self.class.request.get "#{id}/payments", options
    end

    def close
      self.class.request.post "#{id}/close"
    end
  end
end
