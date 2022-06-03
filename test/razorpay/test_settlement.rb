require 'test_helper'

module Razorpay
  # Tests for Razorpay::Settlement
  class RazorpaySettlementTest < Minitest::Test
    class Item < Razorpay::Entity; end

    def setup
      @settlement_id = 'setl_DGlQ1Rj8os78Ec'
      @settlement_ondemand_id = 'setlod_FNj7g2YS5J67Rz'
      @addon_id = 'ao_IrSY3UIqDRx7df'

      # Any request that ends with settlement/settlement_id
      stub_get(%r{settlements\/#{Regexp.quote(@settlement_id)}$}, 'fake_settlement')
    end

    def test_settlement_should_be_defined
      refute_nil Razorpay::Settlement
    end

    def test_settlement_should_be_available
      settlement = Razorpay::Settlement.fetch(@settlement_id)
      assert_instance_of Razorpay::Settlement, settlement, 'Settlement not an instance of Settlement class'
      assert_equal @settlement_id, settlement.id, 'Settlement IDs do not match'
    end

    def test_fetch_all_settlement
      stub_get(/settlements$/, 'settlement_collection')
      settlement = Razorpay::Settlement.all
      assert_instance_of Razorpay::Collection, settlement, 'Settlement should be an array'
      refute_empty settlement.items, 'Settlement should be more than one'
    end

    def test_settlement_reports
      para_attr = {
        "year": 2022,
        "month":12
      }  
      stub_get("#{BASE_URI}settlements/recon/combined?month=12&year=2022", 'settlement_report_collection')
      settlement = Razorpay::Settlement.reports(para_attr)
      assert_instance_of Razorpay::Collection, settlement, 'Settlement not an instance of Settlement class'
      refute_empty settlement.items, 'Settlement should be more than one'
    end

    def test_settlement_should_be_created_on_demand
        para_attr = {
            "amount": 1221,
            "settle_full_balance": false,
            "description": "Testing",
            "notes": {
              "notes_key_1": "Tea, Earl Grey, Hot",
              "notes_key_2": "Tea, Earl Grey… decaf."
            }
          }

        stub_post( %r{settlements/ondemand$},'fake_settlement_on_demand',para_attr.to_json)
        settlement = Razorpay::Settlement.create para_attr.to_json
        assert_instance_of Razorpay::Settlement, settlement, 'Settlement should be an array'
        assert_equal @settlement_id , settlement.id
    end
    
    def test_fetch_all_instant_settlement
      stub_get(%r{settlements/ondemand$}, 'settlement_instant_collection')
      settlement = Razorpay::Settlement.fetch_all_ondemand_settlement
      assert_instance_of Razorpay::Collection, settlement, 'Settlement should be an array'
      refute_empty settlement.items, 'Settlement should be more than one'
    end

    def test_fetch_ondemand_settle_by_id
      stub_get(%r{settlements/ondemand/#{@settlement_id}$}, 'fake_instant_settlement')  
      settlement = Razorpay::Settlement.fetch_ondemand_settlement_by_id(@settlement_id)
      assert_equal @settlement_ondemand_id, settlement.id, 'Settlement IDs do not match'
      refute settlement.settle_full_balance  
    end
  end
end
