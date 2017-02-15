require 'openssl'

# Helper functions are defined here
module Razorpay
  class Utility
    def self.validate_payment_signature(attributes)
      signature = attributes[:razorpay_signature]
      order_id = attributes[:razorpay_order_id]
      payment_id = attributes[:razorpay_payment_id]

      data = [order_id, payment_id].join '|'

      return validate_signature(signature, data)
    end

    private

    def self.validate_signature(signature, data)
      secret = Razorpay.auth[:password]

      expected_signature = OpenSSL::HMAC.hexdigest('SHA256', secret, data)

      return secure_compare(expected_signature, signature)
    end

    def self.secure_compare(a, b)
      return false unless a.bytesize == b.bytesize

      l = a.unpack("C*")

      r, i = 0, -1
      b.each_byte { |v| r |= v ^ l[i+=1] }

      return r == 0
    end
  end
end
