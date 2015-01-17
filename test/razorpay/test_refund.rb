require 'test_helper'
require 'razorpay/payment'
require 'razorpay/refund'

module Razorpay
  # Tests for Razorpay::Refund
  class RazorpayRefundTest < Minitest::Test
    def setup
      @payment_id = 'fake_payment_id'
      stub_get(/payments\/#{Regexp.quote(@payment_id)}$/, 'fake_payment')
    end

    def test_refund_should_be_defined
      refute_nil Razorpay::Refund
    end

    def test_fetch_all_refunds
      stub_get(%r{/payments/#{@payment_id}/refunds$}, 'refund_collection')
      refunds = Razorpay::Payment.fetch(@payment_id).refunds.all
      assert_instance_of Razorpay::Collection, refunds
    end

    def test_fetch_specific_refund
      refund_id = 'fake_refund_id'
      stub_get(%r{payments/#{@payment_id}/refunds/#{refund_id}$}, 'fake_refund')
      refund = Razorpay::Payment.fetch(@payment_id).refunds.fetch('fake_refund_id')
      assert_instance_of Razorpay::Refund, refund
      assert_equal refund.id, refund_id
    end
  end
end
