require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  ## Interact with Addon Delete Api
  class Addon < Entity
    def self.request
      Razorpay::Request.new('addons')
    end

    def self.delete(id)
      request.delete id
    end
  end
end
