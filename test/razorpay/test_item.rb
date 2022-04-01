require 'test_helper'

module Razorpay
  # Tests for Razorpay::Item
  class RazorpayItemTest < Minitest::Test
    def setup
      @item_id = 'item_JDcbIdX9xojCje'

      # Any request that ends with items/item_id
      stub_get(%r{items/#{@item_id}$}, 'fake_item')
      stub_get(/items$/, 'item_collection')
    end

    def test_item_should_be_defined
      refute_nil Razorpay::Item
    end

    def test_item_should_be_created
      
      param_attr = {
        "name": "Book / English August",
        "description": "An indian story, Booker prize winner.",
        "amount": 20000,
        "currency": "INR"
      } 

      stub_post(/items$/, 'fake_item', param_attr.to_json)
      items = Razorpay::Item.create(param_attr.to_json)
      assert_equal @item_id, items.id
      assert_equal true, items.active
    end

    def test_edit_items
      
       param_attr = {
        "name": "Book / English August",
        "description": "An indian story, Booker prize winner.",
        "amount": 20000,
        "currency": "INR"
       }

      stub_patch(%r{items/#{@item_id}$}, 'fake_item', param_attr.to_json)
      item = Razorpay::Item.edit(@item_id, param_attr.to_json)
      assert_instance_of Razorpay::Entity, item
      assert_equal @item_id, item.id, 'Item IDs do not match'
    end

    def test_fetch_all_items
      items = Razorpay::Item.all
      assert_instance_of Razorpay::Collection, items, 'Items should be an array'
      refute_empty items.items, 'Items should be more than one'
    end

    def test_fetch_specific_item
      item = Razorpay::Item.fetch(@item_id)
      assert_instance_of Razorpay::Entity, item
      assert_equal @item_id, item.id, 'Item IDs do not match'
    end
 
    def test_delete_item
      stub_delete(%r{items/#{@item_id}$}, 'empty')
      item = Razorpay::Item.delete(@item_id)
      assert_instance_of Razorpay::Entity, item
    end
  end
end
