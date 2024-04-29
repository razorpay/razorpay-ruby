require 'test_helper'

module Razorpay
  # Tests for Razorpay::Iin
  class RazorpayIinTest < Minitest::Test
    def setup
      @token_id = '411111'
    end

    def test_iin_should_be_defined
      refute_nil Razorpay::Iin
    end

    def test_iin_should_be_fetched
      stub_get(%r{iins/#{@token_id}$}, 'fake_iin_token')
      token = Razorpay::Iin.fetch(@token_id)
      assert_instance_of Razorpay::Iin, token, 'Iin not an instance of Razorpay::Iin class'
      assert_equal @token_id, token.iin, 'token IDs do not match'
    end

    def test_fetch_all_iins
      stub_get(%r{iins/list$}, 'iin_collection')
      list = Razorpay::Iin.all
      refute_nil list.iins
    end
  end
end
