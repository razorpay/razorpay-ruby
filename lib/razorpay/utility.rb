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

    def self.verify_payment_link_signature(attributes)
      signature = attributes.delete(:razorpay_signature)
      # element of each is the value. These are joined.
      data = attributes.values.join('|')
      secret = Razorpay.auth[:password]
      verify_signature(data, signature, secret)
    end

    def self.verify_webhook_signature(body, signature, secret)
      verify_signature(body, signature, secret)
    end

    def self.generate_onboarding_signature(body, secret)
      json_data = body.to_json
      encrypt(json_data, secret);
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

      def encrypt(data, secret)
        key = secret[0, 16]

        # Generate a fresh random 12-byte nonce per call (fixes AES-GCM nonce reuse).
        # A static IV derived from the secret allows keystream recovery and tag forgery
        # (NIST SP 800-38D §8.3 Forbidden Attack) using only two captured ciphertexts.
        iv = OpenSSL::Random.random_bytes(12)

        cipher = OpenSSL::Cipher.new('aes-128-gcm')
        cipher.encrypt
        cipher.key = key
        cipher.iv = iv

        cipher.auth_data = ""

        encrypted = cipher.update(data) + cipher.final

        tag = cipher.auth_tag

        # Output format: iv (12 bytes) || ciphertext || tag (16 bytes), hex-encoded.
        # Receiver must read the first 24 hex chars as the IV before decrypting.
        (iv + encrypted + tag).unpack1("H*")
      end
    end
  end
end
