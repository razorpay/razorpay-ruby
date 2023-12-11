require 'test_helper'

module Razorpay
  # Tests for Razorpay::Addon
  class RazorpayGenericTest < Minitest::Test
    class Generic < Razorpay::Entity; end

    def setup
      @order_id = 'order_50sX9hGHZJvjjI'
      @customer_id = 'cust_6vRXClWqnLhV14'
      @invoice_id = 'inv_6vRZmJYFAG1mNq'
      @addon_id = 'ao_IrSY3UIqDRx7df'
    end

    def test_generic_should_be_defined
      refute_nil Razorpay::Generic
    end
   
    # Test fetch endpoint by order entity
    def test_generic_orders_should_be_fetch   
      stub_get(%r{orders/#{@order_id}$}, 'fake_order')

      client = Razorpay::Generic.new("orders")
      
      order = client.do(@order_id)

      assert_equal 5000, order.amount
      assert_equal 'INR', order.currency
      assert_equal 'TEST', order.receipt
    end

    # Test post endpoint by order entity
    def test_generic_orders_should_be_create
       para_attr = {
         "amount": 5000
       }

      stub_post("#{BASE_URI}/v1/orders/", 'fake_order', para_attr.to_json)
     
      client = Razorpay::Generic.new("orders")
      order = client.do("", "Post", para_attr.to_json)
      assert_equal 5000, order.amount
      assert_equal 'INR', order.currency
      assert_equal 'TEST', order.receipt
    end

    # Test fetch endpoint by order entity
    def test_generic_orders_should_be_edit
        para_attr = {
          "notes": {
            "purpose": "Test UPI QR code notes uodate"
          }
        }
 
       stub_patch("#{BASE_URI}/v1/orders/#{@order_id}", 'fake_order', para_attr.to_json)
      
       client = Razorpay::Generic.new("orders")
       order = client.do(@order_id, "Patch", para_attr.to_json)
       assert_equal 5000, order.amount
       assert_equal 'INR', order.currency
       assert_equal 'TEST', order.receipt
     end

    # Test post endpoint by order entity 
    def test_generic_customer_should_be_create
        para_attr = {
           "name": "Gaurav Kumar",
           "contact": 9123456780,
           "email": "gaurav.kumar@example.com",
           "notes": {
             "notes_key_1": "Tea, Earl Grey, Hot",
             "notes_key_2": "Tea, Earl Grey… decaf."
           }
        }
 
       stub_post("#{BASE_URI}/v1/customers/", 'fake_customer', para_attr.to_json)
      
       client = Razorpay::Generic.new("customers")
       customer = client.do("","Post", para_attr.to_json)
       assert_equal 'test@razorpay.com', customer.email
       assert_equal '9876543210', customer.contact
    end

    # Test put endpoint by order entity 
    def test_generic_customer_should_be_edit
        para_attr = {
           "contact": 9123456780,
        }
 
       stub_put("#{BASE_URI}/v1/customers/#{@customer_id}", 'fake_customer', para_attr.to_json)
      
       client = Razorpay::Generic.new("customers")
       customer = client.do(@customer_id, "Put", para_attr.to_json)
       assert_equal 'test@razorpay.com', customer.email
       assert_equal '9876543210', customer.contact
    end
    
    def test_generic_delete_specific_invoice
      stub_delete(%r{invoices/#{@invoice_id}$}, 'empty')
      client = Razorpay::Generic.new("invoices")
      invoice = client.do("#{@invoice_id}", "Delete")
      refute_nil invoice
    end

    def test_generic_delete_addon
      stub_delete(%r{addons/#{@addon_id}$}, 'empty')
      client = Razorpay::Generic.new("addons")
      addon = client.do("#{@addon_id}", "Delete")
      refute_nil addon
    end
  end
end
