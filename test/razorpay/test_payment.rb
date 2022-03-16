require 'test_helper'

module Razorpay
  # Tests for Razorpay::Payment
  class RazorpayPaymentTest < Minitest::Test
    def setup
      @payment_id = 'fake_payment_id'
      @downtime_id = 'fake_downtime_id'
      @card_id = 'card_7EZLhWkDt05n7V'
      @transfer_id = 'trf_J0FrZYPql4riDx'
      @refund_id = 'fake_refund_id'
      # Any request that ends with payments/payment_id
      stub_get(%r{payments\/#{@payment_id}$}, 'fake_payment')
      stub_get(/payments$/, 'payment_collection')
    end

    def test_payment_should_be_defined
      refute_nil Razorpay::Payment
    end

    def test_payments_should_be_available
      payment = Razorpay::Payment.fetch(@payment_id)
      assert_instance_of Razorpay::Payment, payment, 'Payment not an instance of Payment class'
      assert_equal @payment_id, payment.id, 'Payment IDs do not match'
      assert_equal 500, payment.amount, 'Payment amount is accessible'
      assert_equal 'card', payment.method, 'Payment method is accessible'
    end

    def test_payments_fetch_downtime
      stub_get( %r{payments/downtimes$}, 'downtimes_collection')
      payments = Razorpay::Payment.fetchPaymentDowntime
      assert_instance_of Razorpay::Collection, payments, 'Payment not an instance of Razorpay::Payment class'
      assert !payments.items.empty?, 'downtimes should be more than one'
    end
    
    def test_payments_fetch_downtime_by_id
      stub_get( %r{payments/downtimes/#{@downtime_id}$}, 'fake_downtime')
      payment = Razorpay::Payment.fetchPaymentDowntimeById(@downtime_id)
      assert_instance_of Razorpay::Payment, payment, 'Payment not an instance of Razorpay::Payment class'
      assert_equal @downtime_id , payment.id
    end
    
    def test_payments_fetch_card_details
      stub_get( %r{payments/#{@payment_id}/card$}, 'fake_card')
      payment = Razorpay::Payment.fetchCardDetails(@payment_id)
      assert_instance_of Razorpay::Card, payment, 'Payment not an instance of Razorpay::Payment class'
      assert_equal @card_id , payment.id
    end 

    def test_payments_fetch_multiple_refund_for_payment
      stub_get( %r{payments/#{@payment_id}/refunds$}, 'refund_collection')
      payments = Razorpay::Payment.fetch(@payment_id).fetchMultipleRefund
      assert_instance_of Razorpay::Collection, payments, 'Payment not an instance of Razorpay::Payment class'
      assert !payments.items.empty?, 'downtimes should be more than one'
    end

    def test_payments_fetch_transfers
      stub_get(%r{payments/#{@payment_id}/transfers$}, 'transfers_collection')
      payments = Razorpay::Payment.fetch(@payment_id).fetchTransfer
      assert_instance_of Razorpay::Collection, payments, 'Payment not an instance of Razorpay::Payment class'
      assert !payments.items.empty?, 'payments should be more than one'
    end 

    def test_payments_fetch_refunds
      stub_get(%r{payments/#{@payment_id}/refunds/#{@refund_id}$}, 'fake_refund')
      payments = Razorpay::Payment.fetchRefund(@payment_id,@refund_id)
      assert_instance_of Razorpay::Refund, payments, 'Payment not an instance of Razorpay::Payment class'
      assert_equal @refund_id, payments.id
    end 

    def test_payment_create_recurring
      
       payment_attr = {
          "email": "gaurav.kumar@example.com",
          "contact": "9123456789",
          "amount": 1000,
          "currency": "INR",
          "order_id": "order_1Aa00000000002",
          "customer_id": "cust_1Aa00000000001",
          "token": "token_1Aa00000000001",
          "recurring": "1"
      }
      
       stub_post(%r{payments/create/recurring$}, 'fake_recurring', URI.encode_www_form(payment_attr)) 
       payment = Razorpay::Payment.createRecurringPayment payment_attr
       assert_equal 'pay_1Aa00000000001', payment.razorpay_payment_id
      
    end

    def test_all_payments
      payments = Razorpay::Payment.all
      assert_instance_of Razorpay::Collection, payments, 'Payments should be an array'
      assert !payments.items.empty?, 'Payments should be more than one'
    end

    def test_all_payments_with_options
      query = { 'count' => 1 }
      stub_get(/payments\?count=1$/, 'payment_collection_with_one_payment')
      payments = Razorpay::Payment.all(query)
      assert_equal query['count'], payments.items.size, 'Payments array size should match'
    end

    def test_payment_refund
      stub_post(%r{payments/#{@payment_id}/refund$}, 'fake_refund', {})
      refund = Razorpay::Payment.fetch(@payment_id).refund
      assert_instance_of Razorpay::Refund, refund
      assert_equal refund.payment_id, @payment_id
    end

    def test_payment_refund!
      payment = Razorpay::Payment.fetch(@payment_id)
      stub_get(%r{payments/#{@payment_id}$}, 'fake_refunded_payment')
      stub_post(%r{payments/#{@payment_id}/refund$}, 'fake_refund', {})
      payment.refund!
      assert_equal 'refunded', payment.status
    end

    def test_partial_refund
      # For some reason, stub doesn't work if I pass it a hash of post body
      stub_post(%r{payments/#{@payment_id}/refund$}, 'fake_refund', 'amount=2000')
      refund = Razorpay::Payment.fetch(@payment_id).refund(amount: 2000)
      assert_instance_of Razorpay::Refund, refund
      assert_equal refund.payment_id, @payment_id
      assert_equal refund.amount, 2000
    end

    def test_payment_capture
      stub_post(%r{payments/#{@payment_id}/capture$}, 'fake_captured_payment', 'amount=5100')
      payment = Razorpay::Payment.fetch(@payment_id).capture(amount: 5100)
      assert_equal 'captured', payment.status
    end

    def test_payment_capture!
      stub_post(%r{payments/#{@payment_id}/capture$}, 'fake_captured_payment', 'amount=5100')
      payment = Razorpay::Payment.fetch(@payment_id)
      payment.capture!(amount: 5100)
      assert_equal 'captured', payment.status
    end

    def test_payment_capture_without_fetch
      stub_post(%r{payments/#{@payment_id}/capture$}, 'fake_captured_payment', 'amount=5100')
      payment = Razorpay::Payment.capture(@payment_id, amount: 5100)
      assert_equal 'captured', payment.status
    end

    def test_payment_edit

      payment_attr = {
        "notes": {
          "key1": 'value1',
          "key2": 'value2'
        }
      } 
      
      stub_patch(%r{payments\/#{"pay_IY4ljejpy9KUr9"}$}, 'fake_update_payment', payment_attr.to_json)
      payment = Razorpay::Payment.edit("pay_IY4ljejpy9KUr9",payment_attr.to_json)
      assert_equal 'captured', payment.status
    end

    def test_payment_create_payment_json

      payment_attr = {
        amount: '100',
        currency: 'INR',
        email: 'gaurav.kumar@example.com',
        contact: '9123456789',
        order_id: 'order_EAkbvXiCJlwhHR',
        method: 'card'
      }

      stub_post(%r{payments/create/json$}, 'create_json_payment', URI.encode_www_form(payment_attr)) 
      payment = Razorpay::Payment.createJsonPayment payment_attr 
      assert_equal 'pay_FVmAstJWfsD3SO', payment.razorpay_payment_id
    end
  end
end
