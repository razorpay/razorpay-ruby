require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Item API allows you to create and fetch customers on Razorpay
  class Item < Entity
    def self.request
      Razorpay::Request.new('items')
    end

    def self.create(options)
      request.create options
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.edit(id, options = {})
      if(!options.is_a?(String) && options.key?(:active))
        options[:active] = (options[:active] ? 1 : 0)
      end 
      request.patch id, options
    end

    def self.all(options = {})
      request.all options
    end

    def self.delete(id)
        request.delete id
    end    
  end
end
