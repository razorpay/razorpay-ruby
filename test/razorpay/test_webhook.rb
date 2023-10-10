require 'test_helper'

module Razorpay
  # Tests for Razorpay::Webhook
  class RazorpayWebhookonTest < Minitest::Test
    class Webhook < Razorpay::Entity; end

    def setup
      @webhook_id = 'H000000000000H'
      @account_id = 'acc_00000000000001'
      @alert_email = 'gaurav.kumar@example.com'
      # Any request that ends with webhook_id
    end

    def test_product_should_be_defined
      refute_nil Razorpay::Webhook
    end

    def test_webhook_with_account_id_should_be_available
      stub_get(%r{/v2/accounts\/#{Regexp.quote(@account_id)}/webhooks\/#{Regexp.quote(@webhook_id)}$}, 'fake_webhook_by_account_id')  
      webhook = Razorpay::Webhook.fetch(@webhook_id, @account_id)
      assert_instance_of Razorpay::Webhook, webhook, 'webhook not an instance of Webhook class'
      assert_equal @webhook_id, webhook.id, 'Webhook IDs do not match'
      assert_equal @alert_email, webhook.alert_email, 'webhook alert_email is accessible'
    end

    def test_webhook_with_account_id_should_be_create
      payload = create_webhook_payload_by_account()
      stub_post(%r{/v2/accounts/#{@account_id}/webhooks$}, 'fake_webhook_by_account_id', payload.to_json)

      webhook = Razorpay::Webhook.create(payload.to_json, @account_id)
      assert_instance_of Razorpay::Webhook, webhook, 'Webhook not an instance of Webhook class'
      assert_equal @webhook_id, webhook.id, 'Webhook IDs do not match'
      assert_equal @alert_email, webhook.alert_email, 'webhook alert_email is accessible'
    end

    def test_webhook_should_be_create
      payload = create_webhook_payload()
      stub_post(%r{/webhooks$}, 'fake_webhook', payload.to_json)
  
      webhook = Razorpay::Webhook.create(payload.to_json)
      assert_instance_of Razorpay::Webhook, webhook, 'Webhook not an instance of Webhook class'
      assert_equal @webhook_id, webhook.id, 'Webhook IDs do not match'
      assert_equal @alert_email, webhook.created_by_email, 'webhook alert_email is accessible'
    end

    def test_webhook_with_account_id_should_be_edit
      payload = edit_webhook_payload_by_account()
      stub_patch(%r{/v2/accounts/#{@account_id}/webhooks/#{@webhook_id}$}, 'fake_webhook_by_account_id', payload.to_json)
  
      webhook = Razorpay::Webhook.edit(payload.to_json, @webhook_id, @account_id)
      assert_instance_of Razorpay::Webhook, webhook, 'Webhook not an instance of Webhook class'
      assert_equal @webhook_id, webhook.id, 'Webhook IDs do not match'
      assert_equal @alert_email, webhook.alert_email, 'webhook alert_email is accessible'
    end

    def test_webhook_should_be_edit
      payload = edit_webhook_payload()
      stub_put(%r{/webhooks/#{@webhook_id}$}, 'fake_webhook', payload.to_json)
    
      webhook = Razorpay::Webhook.edit(payload.to_json, @webhook_id)
      assert_instance_of Razorpay::Webhook, webhook, 'Webhook not an instance of Webhook class'
      assert_equal @webhook_id, webhook.id, 'Webhook IDs do not match'
      assert_equal @alert_email, webhook.created_by_email, 'webhook alert_email is accessible'
    end

    def test_webhook_fetch_webhooks_by_account
      stub_get(%r{/v2/accounts/#{@account_id}/webhooks$}, 'webhook_by_account_collection', {})
      
      webhook = Razorpay::Webhook.all({}, @account_id)
      assert_instance_of Razorpay::Collection, webhook, 'Webhook not an instance of Webhook class'
      refute_empty webhook.items , 'Webhook should be more than one'
    end

    def test_webhook_fetch_webhooks
      stub_get(%r{/webhooks$}, 'webhook_collection')
        
      webhook = Razorpay::Webhook.all()
      assert_instance_of Razorpay::Collection, webhook, 'Webhook not an instance of Webhook class'
      refute_empty webhook.items , 'Webhook should be more than one'
    end

    def create_webhook_payload_by_account
        return {
            "url": "https://google.com",
            "alert_email": "gaurav.kumar@example.com",
            "secret": "12345",
            "events": [
              "payment.authorized",
              "payment.failed",
              "payment.captured",
              "payment.dispute.created",
              "refund.failed",
              "refund.created"
            ]
          }
    end

    def edit_webhook_payload_by_account
        return {
            "url": "https://google.com",
            "alert_email": "gaurav.kumar@example.com",
            "secret": "12345",
            "events": [
              "payment.authorized"
            ]
        }
    end    

    def create_webhook_payload
        return {
            "url": "https://google.com",
            "alert_email": "gaurav.kumar@example.com",
            "secret": "12345",
            "events": {
                "payment.authorized": "true",
                "refund.created": "true",
                "subscription.charged": "true"
            }
        }
    end 
    
    def edit_webhook_payload
        return {
            "url": "https://google.com",
            "events": {
                "payment.authorized": "true",
            }
        }
    end
  end
end