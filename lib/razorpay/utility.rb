require 'razorpay'
require 'openssl'

# Helper functions are defined here
module Razorpay
  class Utility
    def self.validate_payment_signature(order_id, payment_id, signature)
      return validate_signature(signature, order_id, payment_id)
    end

    private

    def self.validate_signature(signature, *fields)
      secret = Razorpay.auth[:password]

      data = fields.join('|')

      expected_signature = OpenSSL::HMAC.hexdigest('SHA256', secret, data)

      return expected_signature === signature
    end
  end
end
