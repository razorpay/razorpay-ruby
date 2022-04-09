require 'test_helper'

module Razorpay
  # Tests for Razorpay::Subscription
  class RazorpaySubscriptionTest < Minitest::Test
    class Item < Razorpay::Entity; end

    def setup
      @subscription_id = 'fake_subscription_id'
      @offer_id = 'offer_JCTD1XMlUmzF6Z'
      # Any request that ends with subscriptions/subscription_id
      stub_get(%r{subscriptions\/#{Regexp.quote(@subscription_id)}$}, 'fake_subscription')
      stub_get(/subscriptions$/, 'subscription_collection')
    end

    def test_subscription_should_be_defined
      refute_nil Razorpay::Subscription
    end

    def test_all_subscriptions
      subscriptions = Razorpay::Subscription.all
      assert_instance_of Razorpay::Collection, subscriptions, 'Subscriptions should be an array'
      assert !subscriptions.items.empty?, 'Subscriptions should be more than one'
    end

    def test_subscription_should_be_available
      subscription = Razorpay::Subscription.fetch(@subscription_id)
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'

      assert_equal @subscription_id, subscription.id, 'Subscription IDs do not match'

      assert_subscription_details(subscription)
    end

    def test_subscription_should_be_pause
      para_attr = {
        "pause_at": "now"
      }
      stub_post(%r{subscriptions/#{@subscription_id}/pause$}, 'fake_subscription_pause',para_attr.to_json)
      subscription = Razorpay::Subscription.pause(@subscription_id, para_attr.to_json)
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'
      assert_equal "paused", subscription.status 
    end

    def test_subscription_should_be_resume
      para_attr = {
        "resume_at": "now"
      }
      stub_post(%r{subscriptions/#{@subscription_id}/resume$}, 'fake_subscription_resume',para_attr.to_json)
      subscription = Razorpay::Subscription.resume(@subscription_id, para_attr.to_json)
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'
      assert_equal "resume", subscription.status 
    end

    def test_subscription_pending_update
      stub_get(%r{subscriptions/#{@subscription_id}/retrieve_scheduled_changes$}, 'fake_pending_update')
      subscription = Razorpay::Subscription.fetch(@subscription_id).pending_update
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'
      assert_equal "active", subscription.status
      refute subscription.customer_notify
    end

    def test_subscription_cancel_scheduled_changes
      stub_post(%r{subscriptions/#{@subscription_id}/cancel_scheduled_changes$}, 'fake_pending_update', {})
      subscription = Razorpay::Subscription.cancel_scheduled_changes @subscription_id
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'
      assert_equal "active", subscription.status
      refute subscription.customer_notify
    end

    def test_subscription_delete_offer
      stub_delete(%r{subscriptions/#{@subscription_id}/#{@offer_id}$}, 'fake_pending_update', {})
      subscription = Razorpay::Subscription.delete_offer(@subscription_id,@offer_id)
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'
      assert_equal "active", subscription.status
      refute subscription.customer_notify
    end

    def test_subscription_should_be_created
      time_now = Time.now.to_i
      subscription_attrs = {
        plan_id: 'fake_plan_id', customer_id: 'fake_customer_id',
        start_at: time_now, total_count: 12
      }

      stub_post(/subscriptions$/, 'fake_subscription', subscription_attrs.to_json)

      subscription = Razorpay::Subscription.create subscription_attrs.to_json
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'

      assert_equal @subscription_id, subscription.id, 'Subscription IDs do not match'
      assert_equal 'created', subscription.status, 'Subscription status is accessible'

      assert_subscription_details(subscription)
    end

    def test_subscription_should_be_edited

      subscription_attrs = {
        "plan_id":"plan_00000000000002",
        "offer_id":"offer_JHD834hjbxzhd38d",
        "quantity":5,
        "remaining_count":5,
        "start_at":1496000432,
        "schedule_change_at":"now",
        "customer_notify":1
      }

      stub_patch(%r{/subscriptions/#{@subscription_id}$}, 'fake_subscription', subscription_attrs.to_json)

      subscription = Razorpay::Subscription.fetch(@subscription_id).edit(subscription_attrs.to_json)
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'

       assert_equal @subscription_id, subscription.id, 'Subscription IDs do not match'
       assert_equal 'created', subscription.status, 'Subscription status is accessible'

      #assert_subscription_details(subscription)
    end

    def test_subscription_should_be_created_with_upfront_amount
      subscription_attrs = {
        plan_id: 'fake_plan_id',
        total_count: 12,
        addons: [
          { item: { amount: 100, currency: 'INR' } },
          { item: { amount: 200, currency: 'INR' } }
        ]
      }

      #
      # Note that the stubbed request has the addons array
      # indexed, ensuring that the right request is being built
      #
      # This test will fail if the request sends
      # "addons[][item][amount]=100&addons[][item][currency]=INR" instead
      #
      stub_post(/subscriptions$/, 'fake_subscription', subscription_attrs.to_json)

      Razorpay::Subscription.create subscription_attrs.to_json
    end

    def test_subscription_can_be_cancelled_by_subscription_id
      stub_post(%r{subscriptions\/#{@subscription_id}\/cancel$}, 'cancel_subscription', {})
      subscription = Razorpay::Subscription.cancel(@subscription_id)

      assert_equal @subscription_id, subscription.id, 'Subscription IDs do not match'
      assert_equal 'cancelled', subscription.status, 'Subscription status is accessible'

      assert_subscription_details(subscription)
    end

    def test_subscription_can_be_cancelled_by_subscription_instance
      stub_post(%r{subscriptions\/#{@subscription_id}\/cancel$}, 'cancel_subscription', {})
      subscription = Razorpay::Subscription.fetch(@subscription_id)

      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'
      assert_equal @subscription_id, subscription.id, 'subscription IDs do not match'
      assert_equal 'created', subscription.status, 'Subscription status is accessible'
      assert_nil subscription.ended_at, 'Subscription ended_at is accessible'

      subscription = subscription.cancel(cancel_at_cycle_end: 1)

      assert_equal @subscription_id, subscription.id, 'Subscription IDs do not match'
      assert_equal 'cancelled', subscription.status, 'Subscription status is accessible'
      refute_nil subscription.ended_at, 'Subscription ended_at is accessible'

      assert_subscription_details(subscription)
    end

    def test_subscription_can_be_cancelled_by_subscription_instance!
      stub_post(%r{subscriptions\/#{@subscription_id}\/cancel$}, 'cancel_subscription', {})
      subscription = Razorpay::Subscription.fetch(@subscription_id)
      subscription.cancel!
      assert_equal 'cancelled', subscription.status
    end

    private

    def assert_subscription_details(subscription)
      assert_equal 'fake_plan_id', subscription.plan_id, 'Subscription plan_id is accessible'
      assert_equal 'fake_customer_id', subscription.customer_id, 'Subscription customer_id is accessible'
      assert_equal 12, subscription.total_count, 'Subscription total_count is accessible'
      assert_equal 0, subscription.paid_count, 'Subscription paid_count is accessible'
      refute_nil subscription.charge_at, 'Subscription charge_at is accessible'
      refute_nil subscription.start_at, 'Subscription start_at is accessible'
      refute_nil subscription.end_at, 'Subscription end_at is accessible'
      assert_equal [], subscription.notes, 'Subscription notes is accessible'
    end
  end
end
