require 'test_helper'
require 'razorpay/utility'

module Razorpay
  # Tests for Razorpay::Utility
  class RazorpayUtilityTest < Minitest::Test
    def setup
      Razorpay.setup('key_id', 'key_secret')
    end

    def test_payment_signature_verification
      payment_response = {
        razorpay_order_id: 'fake_order_id',
        razorpay_payment_id: 'fake_payment_id',
        razorpay_signature: 'b2335e3b0801106b84a7faff035df56ecffde06918c9ddd1f0fafbb37a51cc89'
      }
      Razorpay::Utility.verify_payment_signature(payment_response)

      payment_response[:razorpay_signature] = '_dummy_signature' * 4
      assert_raises(SecurityError) do
        Razorpay::Utility.verify_payment_signature(payment_response)
      end
    end
  end
end
