require 'test_helper'

module Razorpay
  # Tests for Razorpay::Entity
  class ErrorTest < Minitest::Test
    def setup
      @payment_id = 'fake_payment_id'
      stub_get(%r{payments\/#{Regexp.quote(@payment_id)}$}, 'fake_payment')
    end

    def test_bad_request_error
      para_attr = {
        amount: 1000,
        currency: 'INR'
      }
      stub_post(%r{payments/#{@payment_id}/capture$}, 'bad_request_error', para_attr.to_json)
      assert_raises Razorpay::BadRequestError, 'It must raise BadRequestError' do
        payment = Razorpay::Payment.fetch(@payment_id)
        payment.capture(para_attr.to_json)
      end
    end
  end
end
