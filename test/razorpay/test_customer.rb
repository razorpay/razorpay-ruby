require 'test_helper'

module Razorpay
  # Tests for Razorpay::Customer
  class RazorpayCustomerTest < Minitest::Test
    def setup
      @customer_id = 'cust_6vRXClWqnLhV14'
      @token_id = "token_FHfn3rIiM1Z8nr"
      @bank_id = "ba_Evg09Ll05SIPSD"
      @eligibilityId = "elig_F1cxDoHWD4fkQt"
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

    def test_customer_fetch_tokens
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
      stub_get(%r{customers/cust_6vRXClWqnLhV14/tokens$}, 'tokens_collection')
      tokens = Razorpay::Customer.fetch(@customer_id).fetchTokens
      assert_instance_of Razorpay::Collection, tokens, 'Tokens should be an array'
      refute_empty tokens.items, 'tokens should be more than one'
    end

    def test_customer_fetch_token
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
      stub_get(%r{customers/cust_6vRXClWqnLhV14/tokens/token_FHfn3rIiM1Z8nr$}, 'fake_token')
      token = Razorpay::Customer.fetch(@customer_id).fetchToken("token_FHfn3rIiM1Z8nr")
      assert_instance_of Razorpay::Token, token, 'Token not an instance of Razorpay::Entity class'
      assert_equal "token_FHfn3rIiM1Z8nr", token.id
    end

    def test_customer_delete_token
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
      stub_delete(%r{customers/cust_6vRXClWqnLhV14/tokens/token_FHfn3rIiM1Z8nr$}, 'delete_token')
      token = Razorpay::Customer.fetch(@customer_id).deleteToken("token_FHfn3rIiM1Z8nr")
      assert token.deleted
    end

    def test_customer_add_bank_account
      para_attr = {
        "ifsc_code": "UTIB0000194",
        "account_number": "916010082985661",
        "beneficiary_name": "Pratheek",
        "beneficiary_address1": "address 1",
        "beneficiary_address2": "address 2",
        "beneficiary_address3": "address 3",
        "beneficiary_address4": "address 4",
        "beneficiary_email": "random@email.com",
        "beneficiary_mobile": "8762489310",
        "beneficiary_city": "Bangalore",
        "beneficiary_state": "KA",
        "beneficiary_country": "IN"
      }

      stub_post(%r{customers/#{@customer_id}/bank_account$}, 'fake_bank_account', para_attr.to_json)
      bankAccount = Razorpay::Customer.add_bank_account(@customer_id, para_attr.to_json)
      assert bankAccount.bank_name
    end

    def test_customer_add_bank_account_exception 
      para_attr = {}
      stub_post(%r{customers/#{@customer_id}/bank_account$}, 'error_customer', para_attr.to_json)
        assert_raises(Razorpay::Error) do
        customer = Razorpay::Customer.add_bank_account(@customer_id, para_attr.to_json)
        if customer.error
            raise Razorpay::Error.new, customer.error['code']
        end 
      end
    end

    def test_customer_delete_bank_account
      stub_delete(%r{customers/#{@customer_id}/bank_account/#{@bank_id}$}, 'success')
      bankAccount = Razorpay::Customer.delete_bank_account(@customer_id, @bank_id)
      assert bankAccount.success
    end

    def test_customer_delete_bank_account_exception 
    stub_delete(%r{customers/#{@customer_id}/bank_account/#{@bank_id}$}, 'error_customer')
      assert_raises(Razorpay::Error) do
        customer = Razorpay::Customer.delete_bank_account(@customer_id,@bank_id)
        if customer.error
          raise Razorpay::Error.new, customer.error['code']
        end 
      end
    end

    def test_customer_request_eligiblity_check
      para_attr = {
        "inquiry": "affordability",
        "amount": 500000,
        "currency": "INR",
        "customer": {
          "id": "cust_KhP5dO1dKmc0Rm",
          "contact": "+918220276214",
          "ip": "105.106.107.108",
          "referrer": "https://merchansite.com/example/paybill",
          "user_agent": "Mozilla/5.0"
        }
      }
      stub_post(%r{customers/eligibility$}, 'fake_eligiblity', para_attr.to_json)
      bankAccount = Razorpay::Customer.request_eligibility_check(para_attr.to_json)
      assert bankAccount.amount
    end

    def test_customer_fetch_eligiblity_check_exception
      para_attr = {
        "inquiry": "affordability",
        "currency": "INR",
        "customer": {
          "id": "cust_KhP5dO1dKmc0Rm",
          "contact": "+918220276214",
          "ip": "105.106.107.108",
          "referrer": "https://merchansite.com/example/paybill",
          "user_agent": "Mozilla/5.0"
        }
      }
      stub_post(%r{customers/eligibility$}, 'error_eligibility_check', para_attr.to_json)     
      assert_raises(Razorpay::Error) do
        customer = Razorpay::Customer.request_eligibility_check(para_attr.to_json)      
        if customer.error
          raise Razorpay::Error.new, customer.error['code']
        end  
      end
    end

    def test_customer_fetch_eligiblity
      stub_get(%r{customers/eligibility/#{@eligibilityId}$}, 'fake_eligiblity')
      bankAccount = Razorpay::Customer.fetch_eligibility(@eligibilityId)
      assert bankAccount.amount
    end

    def test_customer_fetch_eligiblity_exception
      stub_get(%r{customers/eligibility/#{@eligibilityId}$}, 'error_eligibility_check')
      assert_raises(Razorpay::Error) do
        customer = Razorpay::Customer.fetch_eligibility(@eligibilityId)      
        if customer.error
          raise Razorpay::Error.new, customer.error['code']
        end  
      end
    end
  end
end
