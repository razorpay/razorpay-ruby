require 'test_helper'
require 'razorpay/entity'

module Razorpay
  # Tests for Razorpay::Entity
  class EntityTest < Minitest::Test
    def setup
      @hash = { 'a' => 1 }
      @entity = Entity.new(@hash)
    end

    def test_attribute_get
      assert_equal @hash['a'], @entity.a
    end

    def test_json_conversion
      assert_equal '{"a":1}', @entity.to_json
    end

    def test_invalid_attribute_get
      assert_raises(NameError, 'It must raise a NameError on invalid attribute') { @entity.b }
    end
  end
end
