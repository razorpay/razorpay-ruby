require 'openssl'

module Razorpay
  # Helper functions are defined here
  class Utility
    def self.validate_payment_signature(attributes)
      signature = attributes[:razorpay_signature]
      order_id = attributes[:razorpay_order_id]
      payment_id = attributes[:razorpay_payment_id]

      data = [order_id, payment_id].join '|'

      validate_signature(signature, data)
    end

    class << self
      private

      def validate_signature(signature, data)
        secret = Razorpay.auth[:password]

        expected_signature = OpenSSL::HMAC.hexdigest('SHA256', secret, data)

        secure_compare(expected_signature, signature)
      end

      def secure_compare(a, b)
        return false unless a.bytesize == b.bytesize

        l = a.unpack('C*')
        r = 0
        i = -1

        b.each_byte do |v|
          i += 1
          r |= v ^ l[i]
        end

        r.zero?
      end
    end
  end
end
