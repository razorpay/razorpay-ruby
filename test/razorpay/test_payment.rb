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
      payments = Razorpay::Payment.fetch_payment_downtime
      assert_instance_of Razorpay::Collection, payments, 'Payments should be an array'
      refute_empty payments.items, 'payments should be more than one'
    end
    
    def test_payments_fetch_downtime_by_id
      stub_get( %r{payments/downtimes/#{@downtime_id}$}, 'fake_downtime')
      payment = Razorpay::Payment.fetch_payment_downtime_by_id(@downtime_id)
      assert_instance_of Razorpay::Entity, payment, 'Payment not an instance of Razorpay::Payment class'
      assert_equal @downtime_id , payment.id
    end
    
    def test_payments_fetch_card_details
      stub_get( %r{payments/#{@payment_id}/card$}, 'fake_card')
      card = Razorpay::Payment.fetch_card_details(@payment_id)
      assert_instance_of Razorpay::Card, card, 'Card not an instance of Razorpay::Card class'
      assert_equal @card_id , card.id
    end 

    def test_payments_fetch_multiple_refund_for_payment
      stub_get( %r{payments/#{@payment_id}/refunds$}, 'refund_collection',{})
      payments = Razorpay::Payment.fetch_multiple_refund(@payment_id,{})
      assert_instance_of Razorpay::Collection, payments, 'Payment not an instance of Razorpay::Payment class'
      assert !payments.items.empty?, 'payments should be more than one'
    end

    def test_payments_fetch_transfers
      stub_get(%r{payments/#{@payment_id}/transfers$}, 'transfers_collection')
      transfers = Razorpay::Payment.fetch(@payment_id).fetch_transfer
      assert_instance_of Razorpay::Collection, transfers, 'Transfers should be an array'
      assert !transfers.items.empty?, 'transfers should be more than one'
    end 

    def test_payments_post_transfers
      param_attr = {
        "transfers": [
          {
            "account": "acc_CPRsN1LkFccllA",
            "amount": 100,
            "currency": "INR",
            "notes": {
              "name": "Gaurav Kumar",
              "roll_no": "IEC2011025"
            },
            "linked_account_notes": [
              "roll_no"
            ],
            "on_hold": true,
            "on_hold_until": 1671222870
          },
          {
            "account": "acc_CNo3jSI8OkFJJJ",
            "amount": 100,
            "currency": "INR",
            "notes": {
              "name": "Saurav Kumar",
              "roll_no": "IEC2011026"
            },
            "linked_account_notes": [
              "roll_no"
            ],
            "on_hold": false
          }
        ]
      }

      stub_post(%r{payments/#{@payment_id}/transfers$}, 'fake_transfer', param_attr.to_json)
      transfer = Razorpay::Payment.fetch(@payment_id).transfer(param_attr.to_json)
      assert_instance_of Razorpay::Transfer, transfer, 'Transfer not an instance of Razorpay::Transfer class'
      assert transfer.on_hold
    end 

    def test_payments_fetch_refunds
      stub_get(%r{payments/#{@payment_id}/refunds/#{@refund_id}$}, 'fake_refund')
      refund = Razorpay::Payment.fetch(@payment_id).fetch_refund(@refund_id)
      assert_instance_of Razorpay::Refund, refund, 'Refund not an instance of Razorpay::Refund class'
      assert_equal @refund_id, refund.id
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
          "recurring": "1",
          "description": "Creating recurring payment for Gaurav Kumar",
          "notes": {
            "note_key 1": "Beam me up Scotty",
            "note_key 2": "Tea. Earl Gray. Hot."
          }
       }
      
       stub_post(%r{payments/create/recurring$}, 'fake_recurring', payment_attr.to_json) 
       payment = Razorpay::Payment.create_recurring_payment payment_attr.to_json
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
      assert_equal refund.payment_id, "pay_FFX5FdEYx8jPwA"
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
      assert_equal refund.payment_id, "pay_FFX5FdEYx8jPwA"
      assert_equal refund.amount, 2000
    end

    def test_payment_capture

      para_attr = {
        amount: 1000,
        currency: 'INR'
      }

      stub_post(%r{payments/#{@payment_id}/capture$}, 'fake_captured_payment', para_attr.to_json)
      payment = Razorpay::Payment.fetch(@payment_id).capture(para_attr.to_json)
      assert_equal 'captured', payment.status
    end

    def test_payment_capture!
      para_attr = {
       amount: 1000,
       currency: "INR"
      }
      stub_post(%r{payments/#{@payment_id}/capture$}, 'fake_captured_payment', para_attr.to_json)
      payment = Razorpay::Payment.fetch(@payment_id)
      payment.capture!(para_attr.to_json)
      assert_equal 'captured', payment.status
    end

    def test_payment_capture_without_fetch
      stub_post(%r{payments/#{@payment_id}/capture$}, 'fake_captured_payment', 'amount=5100')
      payment = Razorpay::Payment.capture(@payment_id, amount: 5100)
      assert_equal 'captured', payment.status
    end

    def test_otp_generate
      payment_id = 'pay_FVmAstJWfsD3SO'
      stub_post(%r{payments/#{payment_id}/otp_generate$}, 'fake_otp_generate', {})
      payment = Razorpay::Payment.otp_generate(payment_id)
      assert_equal payment_id, payment.razorpay_payment_id
    end

    def test_otp_submit
      param_attr = {
        otp: "123456"
      }
      stub_post(%r{payments/#{@payment_id}/otp/submit$}, 'fake_otp_submit', param_attr.to_json)
      payment = Razorpay::Payment.fetch(@payment_id).otp_submit(param_attr.to_json)
      assert_equal @payment_id, payment.razorpay_payment_id
    end

    def test_otp_resend
      stub_post(%r{payments/#{@payment_id}/otp/resend$}, 'fake_otp_resend', {})
      payment = Razorpay::Payment.fetch(@payment_id).otp_resend
      assert_equal @payment_id, payment.razorpay_payment_id

    def test_payment_edit

      payment_attr = {
        "notes": {
          "notes_key_1": 'Beam me up Scotty.',
          "notes_key_2": 'Engage'
        }
      }
      stub_patch(%r{payments\/#{@payment_id}$}, 'fake_update_payment', payment_attr.to_json)
      payment = Razorpay::Payment.fetch(@payment_id).edit(payment_attr.to_json)
      assert_equal 'payment', payment.entity
      assert_equal 'Beam me up Scotty.', payment.notes["notes_key_1"]
    end

    def test_payment_create_payment_json

      payment_attr = {
        amount: '100',
        currency: 'INR',
        email: 'gaurav.kumar@example.com',
        contact: '9123456789',
        order_id: 'order_EAkbvXiCJlwhHR',
        method: 'card',
        card: {
          number: '4854980604708430',
          cvv: '123',
          expiry_month: '12',
          expiry_year: '21',
          name: 'Gaurav Kumar'
        }
      }

      stub_post(%r{payments/create/json$}, 'create_json_payment',payment_attr.to_json) 
      payment = Razorpay::Payment.create_json_payment payment_attr.to_json 
      assert_equal 'pay_FVmAstJWfsD3SO', payment.razorpay_payment_id
    end
   end 
  end
end
