require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Product API allows you to enable sub-merchants request for a product.
  class Product < Entity

    @@versions = "v2"

    def self.request
      Razorpay::Request.new('accounts')
    end

    def self.request_product_configuration(account_id, options)
      if(!options.is_a?(String) && options.key?(:tnc_accepted))
        options[:tnc_accepted] = (options[:tnc_accepted] ? 1 : 0)
      end
      request.post "#{account_id}/products", options, @@versions
    end

    def self.fetch(account_id, id)
      request.fetch "#{account_id}/products/#{id}", @@versions
    end 

    def self.edit(account_id, id, options = {})
      if(!options.is_a?(String) && options.key?(:tnc_accepted))
        options[:tnc_accepted] = (options[:tnc_accepted] ? 1 : 0)
      end
      request.patch "#{account_id}/products/#{id}", options, @@versions
    end

    def self.fetch_tnc(productName)
      r = request
      r.request :get, "/#{@@versions}/products/#{productName}/tnc", {}
    end
  end
end