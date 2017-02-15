require 'test_helper'

module Razorpay
  # Tests for Razorpay::Entity
  class ErrorTest < Minitest::Test
    def setup
      @payment_id = 'fake_payment_id'
      stub_get(%r{payments\/#{Regexp.quote(@payment_id)}$}, 'fake_payment')
    end

    def test_bad_request_error
      stub_post(%r{payments/#{@payment_id}/capture$}, 'bad_request_error', 'amount=5')
      assert_raises Razorpay::BadRequestError, 'It must raise BadRequestError' do
        payment = Razorpay::Payment.fetch(@payment_id)
        payment.capture(amount: 5)
      end
    end
  end
end
