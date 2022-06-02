require 'test_helper'

module Razorpay
  # Tests for Razorpay::PaymentLink
  class RazorpayPaymentLinkTest < Minitest::Test
    def setup
      @payment_link_id = 'plink_J9feMU9xqHQVWX'

      # Any request that ends with payment_link/payment_link_id
      stub_get(%r{payment_links/#{@payment_link_id}$}, 'fake_payment_link')
      stub_get(/payment_links$/, 'payment_link_collection')
    end

    def test_payment_link_should_be_defined
      refute_nil Razorpay::PaymentLink
    end

    def test_payment_link_should_be_created
      param_attr = {
        "amount": 2244,
        "currency": "INR",
        "accept_partial": true,
        "first_min_partial_amount": 100,
        "description": "For XYZ purpose",
        "customer": {
          "name": "Gaurav Kumar",
          "email": "gaurav.kumar@example.com",
          "contact": "+919999999999"
        },
        "notify": {
          "sms": true,
          "email": true
        },
        "reminder_enable": true,
        "notes": {
          "policy_name": "Jeevan Bima"
        },
        "callback_url": "https://example-callback-url.com/",
        "callback_method": "get"
      }

      stub_post(/payment_links$/, 'fake_payment_link', param_attr.to_json)
      payment_link = Razorpay::PaymentLink.create param_attr.to_json 
      assert_equal @payment_link_id, payment_link.id
    end

    def test_edit_payment_link
      para_attr ={
        "reference_id": "TS35",
        "expire_by": 1653347540,
        "reminder_enable":false,
        "notes":{
          "policy_name": "Jeevan Saral"
        }
      } 

      stub_patch(%r{payment_links/#{@payment_link_id}$}, 'fake_payment_link', para_attr.to_json)
      payment_link = Razorpay::PaymentLink.edit(@payment_link_id,para_attr.to_json)
      assert_instance_of Razorpay::Entity, payment_link
      assert true, payment_link.accept_partial
    end

    def test_fetch_all_payment_link
      stub_get(/payment_links$/, 'payment_link_collection')
      payment_link = Razorpay::PaymentLink.all
      assert_instance_of Razorpay::Collection, payment_link
    end

    def test_fetch_specific_payment
      stub_get(%r{payment_links/#{@payment_link_id}$}, 'fake_payment_link')  
      payment_link = Razorpay::PaymentLink.fetch(@payment_link_id)
      assert_instance_of Razorpay::Entity, payment_link
      assert_equal payment_link.id, @payment_link_id
    end
    
   def test_notify_by_id
      stub_post(%r{payment_links/#{@payment_link_id}/notify_by/email$}, 'payment_link_response',{})  
      payment_link = Razorpay::PaymentLink.notify_by(@payment_link_id,"email")
      assert_instance_of Razorpay::Entity, payment_link
      assert true, payment_link.success
   end
  end
end
