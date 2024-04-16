require 'test_helper'
require 'razorpay/validation_config'

module Razorpay
  # Tests for Razorpay::PayloadValidator
  class RazorpayPayloadValidatorTest < Minitest::Test
    def test_validate_mode
      payload = {
        'mode1' => 'test',
        'mode2' => 'live'
      }
      assert_silent do
        Razorpay::PayloadValidator.validate(payload, [
          Razorpay::ValidationConfig.new('mode1', [:mode]),
          Razorpay::ValidationConfig.new('mode2', [:mode]),
        ])
      end
    end

    def test_mode_validation_failure
      payload = {
        'mode' => 'testvalue'
      }
      assert_raises(Razorpay::Error) do
        Razorpay::PayloadValidator.validate(payload, [
          Razorpay::ValidationConfig.new('mode', [:mode])
        ])
      end
    end

    def test_url_validation_failure
      payload = {
        'redirect_uri' => 'test.com'
      }
      assert_raises(Razorpay::Error) do
        Razorpay::PayloadValidator.validate(payload, [
          Razorpay::ValidationConfig.new('redirect_uri', [:url])
        ])
      end
    end

    def test_non_null_validation_failure
      assert_raises(Razorpay::Error) do
        Razorpay::PayloadValidator.validate({}, [
          Razorpay::ValidationConfig.new('redirect_uri', [:non_null])
        ])
      end
    end

    def test_id_validation_failure
      payload = {
        'client_id' => 'fjidhf'
      }
      assert_raises(Razorpay::Error) do
        Razorpay::PayloadValidator.validate({}, [
          Razorpay::ValidationConfig.new('client_id', [:id])
        ])
      end
    end
  end
end