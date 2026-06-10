require 'test_helper'
require 'openssl'

module Razorpay
  class RazorpayUtilityNegativeTest < Minitest::Test
    def setup
      Razorpay.setup('key_id', 'key_secret')
      @webhook_payload = '{"event":"payment.authorized"}'
      @webhook_secret = 'test_webhook_secret'
    end

    def compute_signature(payload, secret)
      OpenSSL::HMAC.hexdigest('sha256', secret, payload)
    end

    def test_empty_signature_rejected
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_webhook_signature(@webhook_payload, '', @webhook_secret)
      end
    end

    def test_wrong_length_signature_rejected
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_webhook_signature(@webhook_payload, 'abc123', @webhook_secret)
      end
    end

    # Rejected because value doesn't match, not because SDK validates hex format
    def test_wrong_value_signature_rejected
      wrong_sig = 'z' * 64
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_webhook_signature(@webhook_payload, wrong_sig, @webhook_secret)
      end
    end

    def test_tampered_valid_hex_signature_rejected
      tampered_sig = 'a' * 64
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_webhook_signature(@webhook_payload, tampered_sig, @webhook_secret)
      end
    end

    def test_valid_dynamic_signature_accepted
      valid_sig = compute_signature(@webhook_payload, @webhook_secret)
      result = Razorpay::Utility.verify_webhook_signature(@webhook_payload, valid_sig, @webhook_secret)
      assert(result)
    end

    def test_special_chars_in_payload
      special_payload = '{"event":"payment","data":{"notes":"Test & <script>alert(1)</script>"}}'
      valid_sig = compute_signature(special_payload, @webhook_secret)
      result = Razorpay::Utility.verify_webhook_signature(special_payload, valid_sig, @webhook_secret)
      assert(result)
    end

    def test_unicode_in_payload
      unicode_payload = '{"event":"payment","data":{"name":"日本語テスト"}}'
      valid_sig = compute_signature(unicode_payload, @webhook_secret)
      result = Razorpay::Utility.verify_webhook_signature(unicode_payload, valid_sig, @webhook_secret)
      assert(result)
    end
  end
end
