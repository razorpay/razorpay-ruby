require 'test_helper'
require 'json'

module Razorpay
  # Tests for Razorpay::Utility
  class RazorpayUtilityTest < Minitest::Test
    def setup
      Razorpay.setup('key_id', 'key_secret')
    end

    def test_payment_signature_verification
      payment_response = {
        razorpay_order_id: 'fake_other_id',
        razorpay_payment_id: 'fake_payment_id',
        razorpay_signature: '965ee2de4c5c4e6f006fb0a5a1736d992e5d4d52f9fe10b98c9b97ee169ebe18'
      }
      Razorpay::Utility.verify_payment_signature(payment_response)

      payment_response[:razorpay_signature] = '_dummy_signature' * 4
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_payment_signature(payment_response)
      end
    end

    def test_payment_link_signature_verification_exception

      payment_response = {
        payment_link_id: 'fake_razorpay_payment_link_id',
        payment_link_reference_id: 'fake_reference_id',
        payment_link_status: 'paid',
        razorpay_payment_id: 'pay_IH3d0ara9bSsjQ',
        razorpay_signature: 'b8a6acda585c9b74e9da393c7354c7e685e37e69d30ae654730f042e674e0283'
      }

      Razorpay::Utility.verify_payment_link_signature(payment_response)

      payment_response[:razorpay_signature] = '_dummy_signature' * 4  
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_payment_link_signature(payment_response)
      end
    end

    def test_payment_link_signature_verification

      payment_response = {
        payment_link_id: 'fake_razorpay_payment_link_id',
        payment_link_reference_id: 'fake_reference_id',
        payment_link_status: 'paid',
        razorpay_payment_id: 'pay_IH3d0ara9bSsjQ',
        razorpay_signature: 'b8a6acda585c9b74e9da393c7354c7e685e37e69d30ae654730f042e674e0283'
      }

      response = Razorpay::Utility.verify_payment_link_signature(payment_response)
      assert(response)
    end

    def test_subscription_signature_verification
      payment_response = {
        razorpay_payment_id: 'fake_payment_id',
        razorpay_subscription_id: 'fake_other_id',
        razorpay_signature: '3dabcab8ca113e7994cf78c80f8d50974ddfb2d380029743f30a6d67934cd845'
      }
      # A different signature is expected here compared to the previous test,
      # since the sorted order of the keys is different in this case
      Razorpay::Utility.verify_payment_signature(payment_response)

      payment_response[:razorpay_signature] = '_dummy_signature' * 4
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_payment_signature(payment_response)
      end
    end

    def test_webhook_signature_verification
      webhook_body = fixture_file('fake_payment_authorized_webhook')
      secret = 'chosen_webhook_secret'
      signature = 'dda9ca344c56ccbd90167b1be0fd99dfa92fe2b827020f27e2a46024e31c7c99'
      Razorpay::Utility.verify_webhook_signature(webhook_body, signature, secret)

      signature = '_dummy_signature' * 4
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_webhook_signature(webhook_body, signature, secret)
      end
    end

    def test_generate_onboarding_signature
      secret = "EnLs21M47BllR3X8PSFtjtbd"
      timestamp = Time.now.to_i
      body = {
        submerchant_id: 'NSgKfYIR2f9v2y',
        timestamp: timestamp
      }
      encryptedData = Razorpay::Utility.generate_onboarding_signature(body, secret)
      json_data = decrypt(encryptedData, secret)
      body = JSON.parse(json_data)
      assert_equal 'NSgKfYIR2f9v2y', body['submerchant_id'], 'Submerchant IDs do not match'
      assert_equal timestamp, body['timestamp'], 'Timestamps do not match'
    end

    def decrypt(data, secret)
      combined_encrypted_data = [data].pack("H*")

      iv = secret[0, 12]
      key = secret[0, 16]
      tag = combined_encrypted_data[-16..]

      encrypted_data = combined_encrypted_data[0...-16]

      cipher = OpenSSL::Cipher.new('aes-128-gcm')
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv
      cipher.auth_tag = tag
      cipher.auth_data = ""

      cipher.update(encrypted_data) + cipher.final
    end
  end
end
