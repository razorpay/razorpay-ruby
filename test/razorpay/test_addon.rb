require 'test_helper'

module Razorpay
  # Tests for Razorpay::Addon
  class RazorpayAddonTest < Minitest::Test
    class Item < Razorpay::Entity; end

    def setup
      @subscription_id = 'fake_subscription_id'
      @addon_id = 'fake_addon_id'

      # Any request that ends with addons/addon_id
      stub_get(%r{addons\/#{Regexp.quote(@addon_id)}$}, 'fake_addon')
    end

    def test_addon_should_be_defined
      refute_nil Razorpay::Addon
    end

    def test_addon_should_be_available
      addon = Razorpay::Addon.fetch(@addon_id)
      assert_instance_of Razorpay::Addon, addon, 'Addon not an instance of Addon class'
      assert_equal @addon_id, addon.id, 'Addon IDs do not match'
      assert_equal 1, addon.quantity, 'Addon quantity is accessible'
      assert_equal 'fake_subscription_id', addon.subscription_id, 'Addon subscription_id is accessible'
      assert_nil addon.invoice_id, 'Addon invoice_id is accessible'

      assert_addon_item_details(addon)
    end

    def test_add_addons_to_subscription
      addon_attrs = {
        item: {
          name: 'fake_addon_name', currency: 'INR', amount: 5000,
          description: 'fake_addon_description'
        },
        quantity: 1
      }

      stub_post(%r{subscriptions\/#{@subscription_id}\/addons$}, 'fake_addon', create_addon_stub_url_params)

      addon = Razorpay::Addon.create(@subscription_id, addon_attrs)
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

    def create_addon_stub_url_params
      %w(
        item[name]=fake_addon_name&item[currency]=INR&item[amount]=5000&
        item[description]=fake_addon_description&quantity=1
      ).join
    end
  end
end
