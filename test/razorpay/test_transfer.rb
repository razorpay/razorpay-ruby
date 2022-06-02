require 'test_helper'

module Razorpay
  # Tests for Razorpay::Transfer
  class RazorpayTransferTest < Minitest::Test
    def setup
      @transfer_id = 'trf_JDEnyfvGu22ECp'

      # Any request that ends with transfers/transfer_id
      stub_get(%r{/transfers/#{@transfer_id}$}, 'fake_transfer')
    end

    def test_transfer_should_be_defined
      refute_nil Razorpay::Transfer
    end

    def test_create_transfer_reverse
      para_attr = {
          "amount":100
      }  
      stub_post(%r{/transfers/#{@transfer_id}/reversals$}, 'fake_transfer_reverse', para_attr.to_json)
      transfer = Razorpay::Transfer.fetch(@transfer_id)
      transfer.reverse(para_attr.to_json)
      assert_instance_of Razorpay::Transfer, transfer, 'Transfer not an instance of Transfer class'
      assert_equal transfer.id, @transfer_id, 'Transfer transfer_id is accessible'
    end

    def test_transfer_edit
      para_attr = {
        "on_hold": "1",
        "on_hold_until": "1679691505"
      }
      stub_patch(%r{/transfers/#{@transfer_id}$}, 'fake_transfer', para_attr.to_json)
      transfer = Razorpay::Transfer.fetch(@transfer_id)
      transfer.edit(para_attr.to_json);
      assert_instance_of Razorpay::Transfer, transfer, 'Transfer not an instance of Transfer class'
      assert_equal transfer.id, @transfer_id, 'Transfer transfer_id is accessible'
    end

    def test_transfer_fetch
      transfer = Razorpay::Transfer.fetch(@transfer_id)
      assert_instance_of Razorpay::Transfer, transfer, 'Transfer not an instance of Transfer class'
      assert_equal transfer.id, @transfer_id , 'Transfer transfer_id is accessible'
      assert transfer.on_hold
    end

    def test_transfer_fetch_settlement_details
      stub_get("#{BASE_URI}transfers/?expand[]=recipient_settlement", 'transfers_collection')
      transfer = Razorpay::Transfer.fetch_settlements
      assert_instance_of Razorpay::Collection, transfer , 'Transfer should be an array'
      refute_empty transfer.items , 'Transfer should be more than one'
    end

    def test_transfer_fetch_settlements
       para_attr = {
        "recipient_settlement_id":  "setl_DHYJ3dRPqQkAgV"
       }  
      stub_get(/transfers/, 'transfer_settlements_collection',para_attr.to_json)
      transfer = Razorpay::Transfer.all para_attr.to_json
      assert_instance_of Razorpay::Collection, transfer , 'Transfer should be an array'
      refute_empty transfer.items , 'Transfer should be more than one'
    end

    def test_transfer_direct_transfer
        para_attr = {
            "account": "acc_CPRsN1LkFccllA",
            "amount": 100,
            "currency": "INR"
          }  
       stub_post(/transfers/, 'fake_direct_transfer',para_attr.to_json)
       transfer = Razorpay::Transfer.create para_attr.to_json
       assert_instance_of Razorpay::Transfer, transfer, 'Transfer not an instance of Transfer class'
       assert_equal transfer.id, @transfer_id , 'Transfer transfer_id is accessible'
       refute transfer.on_hold
    end
  end
end
