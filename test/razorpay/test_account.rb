require 'test_helper'

module Razorpay
  # Tests for Razorpay::Account
  class RazorpayAccountonTest < Minitest::Test
    class Account < Razorpay::Entity; end

    def setup
      @account_id = 'acc_00000000000001'
      @email = 'gauriagain.kumar@example.org'
      # Any request that ends with account/account_id
      stub_get(%r{/v2/accounts\/#{Regexp.quote(@account_id)}$}, 'fake_account')
    end

    def test_account_should_be_defined
      refute_nil Razorpay::Account
    end

    def test_account_should_be_available
      account = Razorpay::Account.fetch(@account_id)
      assert_instance_of Razorpay::Entity, account, 'Account not an instance of Entity class'
      assert_equal @account_id, account.id, 'Account IDs do not match'
      assert_equal @email, account.email, 'Account email is accessible'
    end

    def test_account_should_be_created
    
      payload = create_account_payload()

      stub_post(/accounts$/,'fake_account',payload.to_json)

      account = Razorpay::Account.create payload.to_json 
      assert_instance_of Razorpay::Entity, account 
      assert_equal @account_id, account.id
    end

    def test_account_edit
    
      param_attr = {
        "notes": {
           "internal_ref_id": "111111"
        }
      }
  
      stub_patch(%r{accounts/#{@account_id}$}, 'fake_account', param_attr.to_json)      

      account = Razorpay::Account.edit(@account_id, param_attr.to_json)
      assert_instance_of Razorpay::Entity, account    
      assert_equal @account_id, account.id
    end

    def test_delete_account
      stub_delete(%r{accounts/#{@account_id}$}, 'fake_account')
      account = Razorpay::Account.delete(@account_id)
      assert_instance_of Razorpay::Entity, account
      assert_equal @account_id, account.id
    end

    def create_account_payload
        return  {
            "email": "gauriagainqzy.kumar@example.org",
            "phone": "9000090000",
            "legal_business_name": "Acme Corp",
            "business_type": "partnership",
            "customer_facing_business_name": "Example",
            "profile": {
              "category": "healthcare",
              "subcategory": "clinic",
              "description": "Healthcare E-commerce platform",
              "addresses": {
                "operation": {
                  "street1": "507, Koramangala 6th block",
                  "street2": "Kormanagala",
                  "city": "Bengaluru",
                  "state": "Karnataka",
                  "postal_code": 560047,
                  "country": "IN"
                },
                "registered": {
                  "street1": "507, Koramangala 1st block",
                  "street2": "MG Road",
                  "city": "Bengaluru",
                  "state": "Karnataka",
                  "postal_code": 560034,
                  "country": "IN"
                }
              },
              "business_model": "Online Clothing ( men, women, ethnic, modern ) fashion and lifestyle, accessories, t-shirt, shirt, track pant, shoes."
            },
            "legal_info": {
              "pan": "AAACL1234C",
              "gst": "18AABCU9603R1ZM"
            },
            "brand": {
              "color": "FFFFFF"
            },
            "notes": {
              "internal_ref_id": "111111"
            },
            "contact_name": "Gaurav Kumar",
            "contact_info": {
              "chargeback": {
                "email": "cb@example.org"
              },
              "refund": {
                "email": "cb@example.org"
              },
              "support": {
                "email": "support@example.org",
                "phone": "9999999998",
                "policy_url": "https://www.google.com"
              }
            },
            "apps": {
              "websites": [
                "https://www.example.org"
              ],
              "android": [
                {
                  "url": "playstore.example.org",
                  "name": "Example"
                }
              ],
              "ios": [
                {
                  "url": "appstore.example.org",
                  "name": "Example"
                }
              ]
            }
          }
    end
  end
end
