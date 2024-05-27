require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Document API allows you to create and fetch document on Razorpay
  class Document < Entity
    def self.request
      Razorpay::Request.new('documents')
    end

    def self.create(options)
      request.create options
    end

    def self.fetch(id)
      request.fetch id
    end
  end
end
