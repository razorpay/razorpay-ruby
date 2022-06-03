require 'test_helper'

module Razorpay
  # Tests for Razorpay::Plan
  class RazorpayPlanTest < Minitest::Test
    def setup
      @plan_id = 'fake_plan_id'

      # Any request that ends with plans/plan_id
      stub_get(%r{plans\/#{Regexp.quote(@plan_id)}$}, 'fake_plan')
      stub_get(/plans$/, 'plan_collection')
    end

    def test_plan_should_be_defined
      refute_nil Razorpay::Plan
    end

    def test_all_plans
      plans = Razorpay::Plan.all
      assert_instance_of Razorpay::Collection, plans, 'Plans should be an array'
      assert !plans.items.empty?, 'Plans should be more than one'
    end

    def test_plan_should_be_available
      plan = Razorpay::Plan.fetch(@plan_id)
      assert_instance_of Razorpay::Plan, plan, 'Plan not an instance of Plan class'
      assert_equal @plan_id, plan.id, 'Plan IDs do not match'
      assert_equal 1, plan.interval, 'Plan interval is accessible'
      assert_equal 'monthly', plan.period, 'Plan period is accessible'
      assert_equal JSON.parse('{"identifier": "plan_monthly_1000"}'), plan.notes, 'Plan notes is accessible'
    end

    def test_plan_should_be_created
      plan_attrs = {
        interval: 1, period: 'monthly',
        item: {
          name: 'Plan 751..1000',
          description: 'Share docs + user mgmt',
          currency: 'INR',
          amount: 500
        },
        notes: { identifier: 'plan_monthly_1000' }
      }

      stub_post(/plans$/, 'fake_plan', plan_attrs.to_json)

      plan = Razorpay::Plan.create plan_attrs.to_json

      assert_equal 1, plan.interval, 'Plan interval is accessible'
      assert_equal 'monthly', plan.period, 'Plan period is accessible'
      assert_equal JSON.parse('{"identifier": "plan_monthly_1000"}'), plan.notes, 'Plan notes is accessible'
    end

    private

    def create_plan_stub_url_params
      %w(
        interval=1&period=monthly&
        item[name]=Plan%20751..1000&
        item[description]=Share%20docs%20%2B%20user%20mgmt&item[currency]=INR&
        item[amount]=500&notes[identifier]=plan_monthly_1000
      ).join
    end
  end
end
