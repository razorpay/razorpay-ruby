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

    def test_addon_should_be_available_failure
      stub_get(%r{disputes\/#{Regexp.quote(@dispute_id)}$}, 'dispute_error')
      assert_raises(Razorpay::Error) do
        dispute = Razorpay::Dispute.fetch(@dispute_id)
        if dispute.error
            raise Razorpay::Error.new, dispute.error['code']
        end
      end  
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

      dispute = Razorpay::Dispute.accept(@dispute_id, param_attr.to_json)
      assert_instance_of Razorpay::Dispute, dispute, 'Dispute not an instance of Dispute class'

      assert_equal @dispute_id, dispute.id, 'Dispute IDs do not match'
      assert_equal 10000, dispute.amount
      assert_equal 0, dispute.amount_deducted
    end

    def test_dispute_accept_failure
      param_attr = {}      
      stub_post(%r{disputes\/#{@dispute_id}\/accept$}, 'dispute_error', param_attr.to_json)
      assert_raises(Razorpay::Error) do
        dispute = Razorpay::Dispute.accept(@dispute_id, param_attr.to_json)
        if dispute.error
            raise Razorpay::Error.new, dispute.error['code']
        end
      end  
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
  
        dispute = Razorpay::Dispute.contest(@dispute_id, param_attr.to_json)
        assert_instance_of Razorpay::Dispute, dispute, 'Dispute not an instance of Dispute class'
  
        assert_equal @dispute_id, dispute.id, 'Dispute IDs do not match'
        assert_equal 10000, dispute.amount
        assert_equal 0, dispute.amount_deducted
      end

      def test_dispute_contest_failure
        param_attr = {}      
        stub_patch(%r{disputes\/#{@dispute_id}\/contest$}, 'dispute_error', param_attr.to_json)
        assert_raises(Razorpay::Error) do
          dispute = Razorpay::Dispute.contest(@dispute_id, param_attr.to_json)
          if dispute.error
              raise Razorpay::Error.new, dispute.error['code']
          end
        end  
      end
  end
end
