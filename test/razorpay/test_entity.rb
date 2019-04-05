require 'test_helper'
require 'ostruct'

module Razorpay
  # Tests for Razorpay::Entity
  class EntityTest < Minitest::Test
    def setup
      @hash = { 'a' => 1 }
      @entity = Entity.new(@hash)
    end

    def test_create_instance
      res = OpenStruct.new(parsed_response: { 'entity' => 'non_existent_entity' })
      entity = Razorpay::Request.new('dummy').create_instance(res)
      assert_instance_of Razorpay::Entity, entity
    end

    def test_raise_error
      error = { 'code' => 'NON_EXISTENT_ERROR', 'description' => 'Unknown error' }
      assert_raises(Razorpay::Error) { Razorpay::Request.new('dummy').raise_error(error, 500) }
    end

    def test_raise_error_server_unreachable
      assert_raises(Razorpay::Error) { Razorpay::Request.new('dummy').raise_error(nil, nil) }
    end

    def test_respond_to_missing_method
      order_id = 'order_50sX9hGHZJvjjI'
      stub_get(%r{orders/#{order_id}$}, 'fake_order')
      order = Razorpay::Order.fetch(order_id)
      assert_equal order.respond_to?(:non_existent_method), false

      payment_id = 'fake_payment_id'
      stub_get(%r{payments/#{payment_id}$}, 'fake_payment')
      payment = Razorpay::Payment.fetch(payment_id)
      assert_equal payment.respond_to?(:method), true
    end

    def test_attribute_get
      assert_equal @hash['a'], @entity.a
    end

    def test_json_conversion
      assert_equal '{"a":1}', @entity.to_json
    end

    def test_json_conversion_with_args
      assert_equal '{"a": 1}', @entity.to_json(space: ' ')
    end

    def test_invalid_attribute_get
      assert_raises(NoMethodError, 'It must raise a NoMethodError on invalid attribute') { @entity.b }
    end
  end
end
