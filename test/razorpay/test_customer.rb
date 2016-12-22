require 'test_helper'
require 'razorpay/customer'
require 'razorpay/collection'

module Razorpay
  # Tests for Razorpay::Customer
  class RazorpayCustomerTest < Minitest::Test
    def setup
      @customer_id = 'cust_6vRXClWqnLhV14'

      # Any request that ends with customers/customer_id
      stub_get(%r{customers/#{@customer_id}$}, 'fake_customer')
    end

    def test_customer_should_be_defined
      refute_nil Razorpay::Customer
    end

    def test_customer_should_be_created
      stub_post(/customers$/, 'fake_customer', 'email=test%40razorpay.com&contact=9876543210')
      customer = Razorpay::Customer.create email: 'test@razorpay.com', contact: '9876543210'

      assert_equal 'test@razorpay.com', customer.email
      assert_equal '9876543210', customer.contact
    end
  end
end
