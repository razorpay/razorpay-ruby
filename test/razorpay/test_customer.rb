require 'test_helper'

module Razorpay
  # Tests for Razorpay::Customer
  class RazorpayCustomerTest < Minitest::Test
    def setup
      @customer_id = 'cust_6vRXClWqnLhV14'
      @token_id = "token_FHfn3rIiM1Z8nr"
      # Any request that ends with customers/customer_id
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
    end

    def test_customer_should_be_defined
      refute_nil Razorpay::Customer
    end

    def test_customer_should_be_created
      stub_post(/customers$/, 'fake_customer', 'email=test%40razorpay.com&contact=9876543210')
      customer = Razorpay::Customer.create email: 'test@razorpay.com', contact: '9876543210'

      assert_equal 'test@razorpay.com', customer.email
      assert_equal '9876543210', customer.contact
    end

    def test_edit_customer
      new_email = 'test.edit@razorpay.com'
      stub_put(%r{customers/#{@customer_id}$}, 'fake_customer_edited', "email=#{new_email}")
      customer = Razorpay::Customer.edit(@customer_id, "email=#{new_email}")
      assert_instance_of Razorpay::Customer, customer
      assert_equal customer.email, new_email
    end

    def test_fetch_all_customers
      stub_get(/customers$/, 'customer_collection')
      customers = Razorpay::Customer.all
      assert_instance_of Razorpay::Collection, customers
    end

    def test_fetch_specific_customer
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
      customer = Razorpay::Customer.fetch(@customer_id)
      assert_instance_of Razorpay::Customer, customer
      assert_equal "test@razorpay.com", customer.email 
    end

    # def test_customer_fetch_tokens
    #   stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
    #   stub_get(%r{customers/cust_6vRXClWqnLhV14/tokens$}, 'tokens_collection')
    #   tokens = Razorpay::Customer.fetch(@customer_id).fetchTokens
    #   assert_instance_of Razorpay::Collection, tokens, 'Tokens should be an array'
    #   refute_empty tokens.items, 'tokens should be more than one'
    # end

    def test_customer_fetch_token
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
      stub_get(%r{customers/cust_6vRXClWqnLhV14/tokens/token_FHfn3rIiM1Z8nr$}, 'fake_token')
      token = Razorpay::Customer.fetch(@customer_id).fetchToken("token_FHfn3rIiM1Z8nr")
      assert_instance_of Razorpay::Entity, token, 'Token not an instance of Razorpay::Entity class'
      assert_equal "token_FHfn3rIiM1Z8nr", token.id
    end

    def test_customer_delete_token
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
      stub_delete(%r{customers/cust_6vRXClWqnLhV14/tokens/token_FHfn3rIiM1Z8nr$}, 'delete_token')
      token = Razorpay::Customer.fetch(@customer_id).deleteToken("token_FHfn3rIiM1Z8nr")
      assert token.deleted
    end
  end
end
