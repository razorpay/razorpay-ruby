require 'test_helper'

module Razorpay

  class RazorpayDisputeonTest < Minitest::Test
    class Dispute < Razorpay::Entity; end

    def setup
      @dispute_id = 'disp_XXXXXXXXXXXXX'

      # Any request that ends with disputes/dispute_id
      stub_get(%r{disputes\/#{Regexp.quote(@dispute_id)}$}, 'fake_dispute')
    end

    def test_dispute_should_be_defined
      refute_nil Razorpay::Addon
    end

    def test_addon_should_be_available
      dispute = Razorpay::Dispute.fetch(@dispute_id)
      assert_instance_of Razorpay::Dispute, dispute, 'Dispute not an instance of Dispute class'
      assert_equal @dispute_id, dispute.id
      assert_equal 'INR', dispute.currency
    end

    def test_fetch_all_dispute
      stub_get(/disputes$/, 'dispute_collection')
      dispute = Razorpay::Dispute.all
      assert_instance_of Razorpay::Collection, dispute, 'Dispute should be an array'
      refute_empty dispute.items, 'Dispute should be more than one'
    end

    def test_dispute_accept

      param_attr = {}
      
      stub_post(%r{disputes\/#{@dispute_id}\/accept$}, 'fake_dispute', param_attr.to_json)

      dispute = Razorpay::Dispute.fetch(@dispute_id).accept(param_attr.to_json)
      assert_instance_of Razorpay::Dispute, dispute, 'Dispute not an instance of Dispute class'

      assert_equal @dispute_id, dispute.id, 'Dispute IDs do not match'
      assert_equal 10000, dispute.amount
      assert_equal 0, dispute.amount_deducted
    end

    def test_dispute_contest

        param_attr = {
            "billing_proof": [
              "doc_EFtmUsbwpXwBG9",
              "doc_EFtmUsbwpXwBG8"
            ],
            "action": "submit"
        }
        
        stub_patch(%r{disputes\/#{@dispute_id}\/contest$}, 'fake_dispute', param_attr.to_json)
  
        dispute = Razorpay::Dispute.fetch(@dispute_id).contest(param_attr.to_json)
        assert_instance_of Razorpay::Dispute, dispute, 'Dispute not an instance of Dispute class'
  
        assert_equal @dispute_id, dispute.id, 'Dispute IDs do not match'
        assert_equal 10000, dispute.amount
        assert_equal 0, dispute.amount_deducted
      end

  end
end
