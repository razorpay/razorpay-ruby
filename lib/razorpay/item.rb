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
