require 'test_helper'
require 'razorpay'

module Razorpay
  # Tests for Razorpay::Utility
  class RazorpayUtilityTest < Minitest::Test
    def setup
      Razorpay.setup('key_id', 'key_secret')
    end

    def test_payment_signature_validation
      order_id = 'fake_order_id'
      payment_id = 'fake_payment_id'
      received_signature = 'b2335e3b0801106b84a7faff035df56ecffde06918c9ddd1f0fafbb37a51cc89'
      valid = Razorpay::Utility.validate_payment_signature(order_id, payment_id, received_signature);
      assert_equal true, valid
      received_signature = 'very_fake_signature'
      valid = Razorpay::Utility.validate_payment_signature(order_id, payment_id, received_signature);
      assert_equal false, valid
    end
  end
end
