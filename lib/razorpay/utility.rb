require 'openssl'

module Razorpay
  # Helper functions are defined here
  class Utility
    def self.verify_payment_signature(attributes)
      signature = attributes.delete(:razorpay_signature)

      # Data requires the values to be in sorted order of their keys.
      # attributes.sort returns a nested array, and the last
      # element of each is the value. These are joined.
      data = attributes.sort.map(&:last).join('|')

      secret = Razorpay.auth[:password]

      verify_signature(data, signature, secret)
    end

    def self.verify_webhook_signature(body, signature, secret)
      verify_signature(body, signature, secret)
    end

    class << self
      private

      def verify_signature(data, signature, secret)
        expected_signature = OpenSSL::HMAC.hexdigest('SHA256', secret, data)

        verified = secure_compare(expected_signature, signature)

        raise SecurityError, 'Signature verification failed' unless verified

        verified
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
