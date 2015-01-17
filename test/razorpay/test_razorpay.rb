require 'test_helper'
require 'razorpay'

module Razorpay
  # Tests for Razorpay
  class RazorpayTest < Minitest::Test
    def setup
      Razorpay.setup('key_id', 'key_secret')
    end

    def test_razorpay_should_be_defined
      refute_nil Razorpay
    end

    def test_setup
      auth = { username: 'key_id', password: 'key_secret' }
      assert_equal auth, Razorpay.auth
    end
  end
end
