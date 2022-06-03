require 'test_helper'

module Razorpay
  # Tests for Razorpay::QrCode
  class RazorpayQrCodeTest < Minitest::Test
    def setup
      @qrcode_id = 'qr_HMsVL8HOpbMcjU'
      @customer_id = 'cust_HKsR5se84c5LTO'
      # Any request that ends with qrcode/qrcode_id
      stub_get(%r{payments/qr_codes/#{@qrcode_id}$}, 'fake_qrcode')
      stub_get(%r{payments/qr_codes$}, 'qrcode_collection')
    end

    def test_qrcode_should_be_defined
      refute_nil Razorpay::QrCode
    end

    def test_qrcode_should_be_created
      para_attr = {
        "type": "upi_qr",
        "name": "Store_1",
        "usage": "single_use",
        "fixed_amount": true,
        "payment_amount": 300,
        "description": "For Store 1",
        "customer_id": "cust_HKsR5se84c5LTO",
        "close_by": 1681615838,
        "notes": {
          "purpose": "Test UPI QR code notes"
        }
      }  
      stub_post(%r{/payments/qr_codes$}, 'fake_qrcode', para_attr.to_json)
      qr_code = Razorpay::QrCode.create(para_attr.to_json)

       assert_equal @qrcode_id, qr_code.id
       assert_equal @customer_id, qr_code.customer_id
    end

    def test_fetch_all_qcode
      qr_code = Razorpay::QrCode.all
      assert_instance_of Razorpay::Collection, qr_code
    end

    def test_fetch_specific_qrcode
      qr_code = Razorpay::QrCode.fetch(@qrcode_id)
      assert_instance_of Razorpay::QrCode, qr_code
      assert_equal qr_code.id, @qrcode_id
    end

    def test_qrcode_close
      stub_post(%r{payments/qr_codes/#{@qrcode_id}/close$}, 'fake_qrcode_close',{})  
      qr_code = Razorpay::QrCode.fetch(@qrcode_id).close
      assert_instance_of Razorpay::QrCode, qr_code
      assert_equal qr_code.id, @qrcode_id
    end

    def test_qrcode_fetch_payments
      stub_get(%r{payments/qr_codes/#{@qrcode_id}/payments$}, 'qrcode_payments_collection',{})  
      qr_code = Razorpay::QrCode.fetch(@qrcode_id).fetch_payments()
      assert_instance_of Razorpay::Collection, qr_code
    end
  end
end
