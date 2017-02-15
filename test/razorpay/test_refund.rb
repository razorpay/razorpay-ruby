require 'test_helper'

module Razorpay
  # Tests for Razorpay::Refund
  class RazorpayRefundTest < Minitest::Test
    def setup
      @payment_id = 'fake_payment_id'
      stub_get(%r{payments/#{@payment_id}$}, 'fake_payment')
      @refund_id = 'fake_refund_id'
      stub_get(%r{refunds/#{@refund_id}$}, 'fake_refund')
    end

    def test_refund_should_be_defined
      refute_nil Razorpay::Refund
    end

    def test_fetch_all_refunds_for_payment
      stub_get(%r{payments/#{@payment_id}/refunds$}, 'refund_collection_for_payment')
      refunds = Razorpay::Payment.fetch(@payment_id).refunds
      assert_instance_of Razorpay::Collection, refunds
    end

    def test_fetch_all_refunds
      stub_get(/refunds$/, 'refund_collection')
      refunds = Razorpay::Refund.all
      assert_instance_of Razorpay::Collection, refunds
    end

    def test_fetch_specific_refund
      refund = Razorpay::Refund.fetch(@refund_id)
      assert_instance_of Razorpay::Refund, refund
      assert_equal refund.id, @refund_id
    end

    def test_create_refund
      stub_post(/refunds$/, 'fake_refund', "payment_id=#{@payment_id}")
      refund = Razorpay::Refund.create(payment_id: @payment_id)
      assert_instance_of Razorpay::Refund, refund
      assert_equal refund.payment_id, @payment_id
    end
  end
end
