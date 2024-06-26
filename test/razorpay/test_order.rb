require 'test_helper'

module Razorpay
  # Tests for Razorpay::Order
  class RazorpayOrderTest < Minitest::Test
    def setup
      @order_id = 'order_50sX9hGHZJvjjI'
      @transfer_id = 'trf_DSkl2lXWbiADZG'
      # Any request that ends with orders/order_id
      stub_get(%r{orders/#{@order_id}$}, 'fake_order')
    end

    def test_order_should_be_defined
      refute_nil Razorpay::Order
    end

    def test_order_should_be_created
      stub_post(/orders$/, 'fake_order', 'amount=5000&currency=INR&receipt=TEST')
      order = Razorpay::Order.create amount: 5000, currency: 'INR', receipt: 'TEST'

      assert_equal 5000, order.amount
      assert_equal 'INR', order.currency
      assert_equal 'TEST', order.receipt
    end

    def test_orders_should_be_fetched
      order = Razorpay::Order.fetch(@order_id)
      assert_instance_of Razorpay::Order, order, 'order not an instance of Razorpay::Order class'
      assert_equal @order_id, order.id, 'order IDs do not match'
    end

    def test_fetching_all_orders
      stub_get(/orders$/, 'order_collection')
      orders = Razorpay::Order.all
      assert_instance_of Razorpay::Collection, orders, 'Orders should be an array'
      assert !orders.items.empty?, 'orders should be more than one'
    end

    def test_order_payments_should_be_fetched
      stub_get(%r{orders/#{@order_id}/payments$}, 'order_payments')

      payments = Razorpay::Order.fetch(@order_id).payments
      assert_instance_of Razorpay::Collection, payments, 'Payments should be an array'
      assert !payments.items.empty?, 'payments should be more than one'
      assert_equal 'pay_50sbkZA9AcyE5a', payments.items[0]['id'], 'payment id should match'
    end

   def test_edit_order
      param_attr = {
        "notes": {
          "key1": "value3",
          "key2": "value2"
        }
      }
     
      stub_patch(%r{orders/#{@order_id}$}, 'fake_order', param_attr.to_json)
      order = Razorpay::Order.edit(@order_id, param_attr.to_json)
      assert_instance_of Razorpay::Order, order, 'order not an instance of Razorpay::Order class'
      assert_equal @order_id, order.id, 'order IDs do not match'
   end

   def test_fetch_order_transfers
    stub_get("#{BASE_URI}/v1/orders/#{@order_id}/?expand[]=transfers&status", 'fake_order_transfers')
    order = Razorpay::Order.fetch_transfer_order(@order_id)
    assert_instance_of Razorpay::Order, order, 'order not an instance of Razorpay::Order class'
    assert_equal @order_id, order.id, 'order IDs do not match'
    refute_empty order.transfers["items"]
    assert_equal @transfer_id, order.transfers["items"][0]["id"]
   end

   def test_view_rto
    stub_post(%r{orders/#{@order_id}/rto_review$}, 'fake_rto', {})
    order = Razorpay::Order.view_rto(@order_id)
    assert !order.rto_reasons.empty?, 'orders should be more than one'
   end

   def test_view_rto_exception
    stub_post(%r{orders/#{@order_id}/rto_review$}, 'order_error', {})
    assert_raises(Razorpay::Error) do
      order = Razorpay::Order.view_rto(@order_id)      
       if order.error
        raise Razorpay::Error.new, order.error['code']
       end  
     end
   end

   def test_fulfillment
      param_attr = {
        "payment_method": "upi",
        "shipping": {
          "waybill": "123456789",
          "status": "rto",
          "provider": "Bluedart"
        }
      }

     stub_post(%r{orders/#{@order_id}/fulfillment$}, 'fake_fulfillment', param_attr.to_json)
     order = Razorpay::Order.edit_fulfillment(@order_id, param_attr.to_json)
     assert_equal "upi", order.payment_method, 'order payment method do not match'
   end

   def test_fulfillment_exception
    para_attr = {}
    stub_post(%r{orders/#{@order_id}/fulfillment$}, 'order_error', para_attr.to_json)
    assert_raises(Razorpay::Error) do
      order = Razorpay::Order.edit_fulfillment(@order_id, para_attr.to_json)
       if order.error
        raise Razorpay::Error.new, order.error['code']
       end  
     end
   end
  end
end
