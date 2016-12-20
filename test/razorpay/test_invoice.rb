require 'test_helper'
require 'razorpay/invoice'
require 'razorpay/collection'

module Razorpay
  # Tests for Razorpay::Invoice
  class RazorpayInvoiceTest < Minitest::Test
    def setup
      @invoice_id = 'inv_6vRZmJYFAG1mNq'

      # Any request that ends with invoices/invoice_id
      stub_get(%r{invoices/#{@invoice_id}$}, 'fake_invoice')
    end

    def test_invoice_should_be_defined
      refute_nil Razorpay::Invoice
    end

    def test_invoice_should_be_created
      stub_post(/invoices$/, 'fake_invoice', 'customer_id=cust_6vRXClWqnLhV14&amount=100&currency=INR&description=Test%20description&type=link')
      invoice = Razorpay::Invoice.create customer_id: 'cust_6vRXClWqnLhV14', amount: 100, currency: 'INR', description: 'Test description', type: 'link'

      assert_equal 'cust_6vRXClWqnLhV14', invoice.customer_id
      assert_equal 100, invoice.amount
      assert_equal 'INR', invoice.currency
      assert_equal 'Test description', invoice.description
      assert_equal 'link', invoice.type
    end

    def test_invoices_should_be_fetched
      invoice = Razorpay::Invoice.fetch(@invoice_id)
      assert_instance_of Razorpay::Invoice, invoice, 'invoice not an instance of Razorpay::Invoice class'
      assert_equal @invoice_id, invoice.id, 'invoice IDs do not match'
    end

    def test_fetching_all_invoices
      stub_get(/invoices$/, 'invoice_collection')
      invoices = Razorpay::Invoice.all
      assert_instance_of Razorpay::Collection, invoices, 'Invoices should be an array'
      assert !invoices.items.empty?, 'invoices should be more than one'
    end
  end
end
