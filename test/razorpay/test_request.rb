require 'test_helper'
require 'json'

module Razorpay
  # Tests for Razorpay::Entity
  class RequestTest < Minitest::Test
    def test_raw_request
      stub_get('https://api.razorpay.com', 'welcome')

      req = Razorpay::Request.new
      res = req.raw_request(:get, 'https://api.razorpay.com')
      assert_equal 'Welcome to Razorpay API.', JSON.parse(res.body)['message']
    end
  end
end
