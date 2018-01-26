require 'test_helper'

module Razorpay
  # Tests for Razorpay::Subscription
  class RazorpaySubscriptionTest < Minitest::Test
    class Item < Razorpay::Entity; end

    def setup
      @subscription_id = 'fake_subscription_id'

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

    def test_subscription_should_be_created
      time_now = Time.now.to_i
      subscription_attrs = {
        plan_id: 'fake_plan_id', customer_id: 'fake_customer_id',
        start_at: time_now, total_count: 12
      }

      stub_params = "plan_id=fake_plan_id&customer_id=fake_customer_id&start_at=#{time_now}&total_count=12"
      stub_post(/subscriptions$/, 'fake_subscription', stub_params)

      subscription = Razorpay::Subscription.create subscription_attrs
      assert_instance_of Razorpay::Subscription, subscription, 'not an instance of Subscription class'

      assert_equal @subscription_id, subscription.id, 'Subscription IDs do not match'
      assert_equal 'created', subscription.status, 'Subscription status is accessible'

      assert_subscription_details(subscription)
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

    def test_subscription_addons_can_be_added
      addon_attrs = {
        item: {
          name: 'fake_addon_name', currency: 'INR', amount: 5000,
          description: 'fake_addon_description'
        },
        quantity: 1
      }

      stub_post(%r{subscriptions\/#{@subscription_id}\/addons$}, 'fake_addon', create_addon_stub_url_params)

      addon = Razorpay::Subscription.addons(@subscription_id, addon_attrs)
      assert_instance_of Razorpay::Addon, addon, 'Addon not an instance of Addon class'

      assert_equal 'fake_addon_id', addon.id, 'Addon IDs do not match'
      assert_equal 1, addon.quantity, 'Addon quantity is accessible'
      assert_equal 'fake_subscription_id', addon.subscription_id, 'Addon subscription_id is accessible'
      assert_nil addon.invoice_id, 'Addon invoice_id is accessible'

      assert_addon_item_details(addon)
    end

    private

    def assert_addon_item_details(addon)
      addon_item = Item.new(addon.item)

      assert_equal 'fake_item_id', addon_item.id, 'Addon Item id is accessible'
      assert_equal 'fake_item_name', addon_item.name, 'Addon Item name is accessible'
      assert_equal 'fake_item_description', addon_item.description, 'Addon Item description is accessible'
      assert_equal 'INR', addon_item.currency, 'Addon Item currency is accessible'
      assert_equal 500, addon_item.amount, 'Addon Item amount is accessible'
    end

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

    def create_addon_stub_url_params
      %w(
        item[name]=fake_addon_name&item[currency]=INR&item[amount]=5000&
        item[description]=fake_addon_description&quantity=1
      ).join
    end
  end
end
