require 'test_helper'
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

    def test_custom_header
      custom_headers = { 'key' => 'value' }
      stub_get(/$/, 'hello_response')
      Razorpay.headers = custom_headers
      Razorpay::Request.new('dummy').make_test_request
      user_agent = "Razorpay-Ruby/#{Razorpay::VERSION}"
      expected_headers = { 'User-Agent' => user_agent }.merge(custom_headers)
      assert_requested :get, 'https://key_id:key_secret@api.razorpay.com/',
                       headers: expected_headers,
                       times: 1
    end

    # We make a request to the / endpoint to test SSL support
    def test_sample_request
      WebMock.allow_net_connect!
      req = Razorpay::Request.new('dummy')
      response = req.make_test_request.parsed_response
      assert_equal 'Welcome to Razorpay API.', response['message']
      WebMock.disable_net_connect!
    end

    # We mock this request
    def test_auth_header_and_user_agent
      stub_get(/$/, 'hello_response')
      Razorpay::Request.new('dummy').make_test_request
      user_agent = "Razorpay-Ruby/#{Razorpay::VERSION}"
      assert_requested :get, 'https://key_id:key_secret@api.razorpay.com/',
                       headers: { 'User-Agent' => user_agent },
                       times: 1
    end
  end
end
