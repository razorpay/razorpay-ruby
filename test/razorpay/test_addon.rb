require 'test_helper'

module Razorpay
  # Tests for Razorpay::Addon
  class RazorpayAddonTest < Minitest::Test
    def setup
      @addon_id = 'fake_addon_id'
    end

    def test_addon_should_be_defined
      refute_nil Razorpay::Addon
    end

    def test_addon_can_be_deleted
      stub_delete(%r{addons\/#{Regexp.quote(@addon_id)}$}, 'delete_addon')

      addon = Razorpay::Addon.delete(@addon_id)
      assert_instance_of Razorpay::Entity, addon, 'Addon not an instance of Addon class but Entity'
      assert_equal 'Void', addon.entity, 'Void Entity is created'
    end
  end
end
