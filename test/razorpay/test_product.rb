require 'test_helper'

module Razorpay
  # Tests for Razorpay::Product
  class RazorpayProductonTest < Minitest::Test
    class Product < Razorpay::Entity; end

    def setup
      @product_id = 'acc_prd_00000000000001'
      @account_id = 'acc_00000000000001'
      @product_name = 'payment_gateway'
      @tnc_id = 'tnc_map_00000000000001'
      # Any request that ends with product_id
      stub_get(%r{/v2/accounts\/#{Regexp.quote(@account_id)}/products\/#{Regexp.quote(@product_id)}$}, 'fake_product')
    end

    def test_product_should_be_defined
      refute_nil Razorpay::Product
    end

    def test_product_should_be_available
      product = Razorpay::Product.fetch(@account_id, @product_id)
      assert_instance_of Razorpay::Entity, product, 'product not an instance of Entity class'
      assert_equal @product_id, product.id, 'Product IDs do not match'
      assert_equal @product_name, product.product_name, 'product name is accessible'
    end

    def test_product_request_product_configuration

      payload = create_product_payload()
      stub_post(%r{accounts/#{@account_id}/products$}, 'fake_product', payload.to_json)

      product = Razorpay::Product.request_product_configuration(@account_id, payload.to_json)
      assert_instance_of Razorpay::Entity, product, 'Product not an instance of Entity class'
      assert_equal @product_id, product.id, 'Product IDs do not match'
      assert_equal @product_name, product.product_name, 'product name is accessible'
    end

    def test_product_edit

      payload = create_product_payload()
      stub_patch(%r{accounts/#{@account_id}/products/#{@product_id}$}, 'fake_product', payload.to_json)

      product = Razorpay::Product.edit(@account_id, @product_id, payload.to_json)
      assert_instance_of Razorpay::Entity, product, 'Product not an instance of Entity class'
      assert_equal @product_id, product.id, 'Product IDs do not match'
      assert_equal @product_name, product.product_name, 'product name is accessible'
    end

    def test_product_fetchTnc
      product_name = "payments"  

      stub_get("#{BASE_URI}/v2/products/#{product_name}/tnc", 'fetch_tnc')  
      product = Razorpay::Product.fetch_tnc(product_name)
      assert_instance_of Razorpay::Entity, product, 'Product not an instance of Entity class'
      assert_equal @tnc_id, product.id, 'Product IDs do not match'
    end

    def create_product_payload
        return {
          "product_name": "payment_gateway",
          "tnc_accepted": true,
          "ip": "233.233.233.234"
        }
    end
  end
end