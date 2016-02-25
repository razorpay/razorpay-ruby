require 'test_helper'
require 'razorpay'
require 'webmock'

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

    # We make a request to the / endpoint to test SSL support
    def test_sample_request
      WebMock.allow_net_connect!
      response = Razorpay::Request.new('dummy').make_test_request
      assert_equal "Welcome to Razorpay API.", response['message']
      WebMock.disable_net_connect!
    end
  end
end
