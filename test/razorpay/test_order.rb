require 'test_helper'

module Razorpay
  # Tests for Razorpay::Order
  class RazorpayOrderTest < Minitest::Test
    def setup
      @order_id = 'order_50sX9hGHZJvjjI'

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
  end
end
