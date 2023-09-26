require 'test_helper'

module Razorpay
  # Tests for Razorpay::Account
  class RazorpayStakeholderonTest < Minitest::Test
    class Stakeholder < Razorpay::Entity; end

    def setup
      @stakeholder_id = 'sth_00000000000001'
      @account_id = 'acc_00000000000001'
      @email = 'gaurav.kumar@example.com'
      # Any request that ends with stakeholder_id
      stub_get(%r{/v2/accounts\/#{Regexp.quote(@account_id)}/stakeholders\/#{Regexp.quote(@stakeholder_id)}$}, 'fake_stakeholder')
    end

    def test_stakeholder_should_be_defined
      refute_nil Razorpay::Stakeholder
    end

    def test_stakeholder_should_be_available
      stakeholder = Razorpay::Stakeholder.fetch(@account_id, @stakeholder_id)
      assert_instance_of Razorpay::Stakeholder, stakeholder, 'Stakeholder not an instance of Entity class'
      assert_equal @stakeholder_id, stakeholder.id, 'Stakeholder IDs do not match'
      assert_equal @email, stakeholder.email, 'Stakeholder email is accessible'
    end

    def test_stakeholder_should_be_create

      payload = create_stakeholder_payload()
      stub_post(%r{accounts/#{@account_id}/stakeholders$}, 'fake_stakeholder', payload.to_json)

      stakeholder = Razorpay::Stakeholder.create(@account_id, payload.to_json)
      assert_instance_of Razorpay::Stakeholder, stakeholder, 'Stakeholder not an instance of Entity class'
      assert_equal @stakeholder_id, stakeholder.id, 'Stakeholder IDs do not match'
      assert_equal @email, stakeholder.email, 'Stakeholder email is accessible'
    end

    def test_stakeholder_edit

      payload = create_stakeholder_payload()     
      stub_patch(%r{accounts/#{@account_id}/stakeholders/#{@stakeholder_id}$}, 'fake_stakeholder', payload.to_json)

      stakeholder = Razorpay::Stakeholder.edit(@account_id, @stakeholder_id, payload.to_json)
      assert_instance_of Razorpay::Stakeholder, stakeholder, 'Stakeholder not an instance of Entity class'
      assert_equal @stakeholder_id, stakeholder.id, 'Stakeholder IDs do not match'
      assert_equal @email, stakeholder.email, 'Stakeholder email is accessible'
    end

    def test_fetching_all_stakeholder
      stub_get(%r{accounts/#{@account_id}/stakeholders$}, 'stakeholder_collection')
      orders = Razorpay::Stakeholder.all(@account_id)
      assert_instance_of Razorpay::Collection, orders, 'Orders should be an array'
      assert !orders.items.empty?, 'orders should be more than one'
    end

    def create_stakeholder_payload
        return  {
            "percentage_ownership": 10,
            "name": "Gaurav Kumar",
            "email": "gaurav.kumar@example.com",
            "relationship": {
              "director": true,
              "executive": false
            },
            "phone": {
              "primary": "9000090000",
              "secondary": "9000090000"
            },
            "addresses": {
              "residential": {
                "street": "506, Koramangala 1st block",
                "city": "Bengaluru",
                "state": "Karnataka",
                "postal_code": "560034",
                "country": "IN"
              }
            },
            "kyc": {
              "pan": "AVOPB1111K"
            },
            "notes": {
              "random_key_by_partner": "random_value"
            }
        }
    end
  end
end