require 'test_helper'

module Razorpay
  # Tests for Razorpay::Token
  class RazorpayTokenTest < Minitest::Test
    class Token < Razorpay::Entity; end

    def setup
      @token_id = 'token_00000000000001'    
      @customer_id = 'cust_1Aa00000000001'
      @method = 'card'
    end

    def test_token_should_be_defined
      refute_nil Razorpay::Token
    end

    def test_token_should_be_available
      payload = {
          "id": @token_id
      }  
      stub_post(%r{/tokens/fetch$}, 'fake_tokenise_customer', payload.to_json)
      token = Razorpay::Token.fetch(payload.to_json)
      assert_instance_of Razorpay::Token, token, 'token not an instance of Token class'
      assert_equal @token_id, token.id, 'Token IDs do not match'
    end

    def test_token_should_be_delete
      payload = {
          "id": @token_id
      }  
      stub_post(%r{/tokens/delete$}, 'empty', payload.to_json)
      token = Razorpay::Token.delete(payload.to_json)
      assert_instance_of Razorpay::Entity, token, 'token not an instance of Entity class'
    end

    def test_token_create

      payload = create_token_payload()
      stub_post(%r{/tokens$}, 'fake_tokenise_customer', payload.to_json)

      token = Razorpay::Token.create(payload.to_json)
      assert_instance_of Razorpay::Token, token, 'Token not an instance of Token class'
      assert_equal @token_id, token.id, 'Token IDs do not match'
    end

    def create_token_payload
        return {
            "customer_id": "cust_00000000000002",
            "method": "card",
            "card": {
              "number": "4854000000708430",
              "cvv": "123",
              "expiry_month": "12",
              "expiry_year": "24",
              "name": "Gaurav Kumar"
            },
            "authentication": {
              "provider": "razorpay",
              "provider_reference_id": "pay_000000000000" 
            },
            "notes": []
        }
    end
  end
end
