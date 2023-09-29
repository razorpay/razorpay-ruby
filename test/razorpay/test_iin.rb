require 'test_helper'

module Razorpay
  # Tests for Razorpay::Iin
  class RazorpayIinTest < Minitest::Test
    def setup
      @token_id = '411111'

      # Any request that ends with token/token_id
      stub_get(%r{iins/#{@token_id}$}, 'fake_iin_token')
    end

    def test_iin_should_be_defined
      refute_nil Razorpay::Iin
    end

    def test_iin_should_be_fetched
      token = Razorpay::Iin.fetch(@token_id)
      assert_instance_of Razorpay::Iin, token, 'Iin not an instance of Razorpay::Iin class'
      assert_equal @token_id, token.iin, 'token IDs do not match'
    end
  end
end
