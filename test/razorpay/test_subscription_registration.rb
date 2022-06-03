require 'test_helper'

module Razorpay
  # Tests for Razorpay::Addon
  class RazorpaySubscriptionRegistrationTest < Minitest::Test

    def setup
      @invoice_id = 'inv_JA7OELdAoxbzk7'
    end

    def test_subscription_registration_should_be_defined
      refute_nil Razorpay::SubscriptionRegistration
    end

    def test_create_registration_link
      param_attr = {
        "customer": {
          "name": "Gaurav Kumar",
          "email": "gaurav.kumar@example.com",
          "contact": 9123456780
        },
        "amount": 0,
        "currency": "INR",
        "type": "link",
        "description": "12 p.m. Meals",
        "subscription_registration": {
          "method": "nach",
          "auth_type": "physical",
          "bank_account": {
            "beneficiary_name": "Gaurav Kumar",
            "account_number": 11214311215411,
            "account_type": "savings",
            "ifsc_code": "HDFC0001233"
          },
          "nach": {
            "form_reference1": "Recurring Payment for Gaurav Kumar",
            "form_reference2": "Method Paper NACH"
          },
          "expire_at": 1648101450,
          "max_amount": 50000
        },
        "receipt": "Receipt No. #12",
        "sms_notify": 1,
        "email_notify": 1,
        "expire_by": 1648101450,
        "notes": {
          "note_key 1": "Beam me up Scotty",
          "note_key 2": "Tea. Earl Gray. Hot."
        }
      }

      stub_post(%r{/subscription_registration/auth_links$}, 'fake_subscription_registration', param_attr.to_json)
      subscription_registration = Razorpay::SubscriptionRegistration.create(param_attr.to_json)
      assert_instance_of Razorpay::Invoice, subscription_registration
      assert_equal subscription_registration.id, @invoice_id
    end
  end
end
