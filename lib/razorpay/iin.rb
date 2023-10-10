require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # IIN API allows you to fetch card properties using token IIN.
  class Iin < Entity
    def self.request
      Razorpay::Request.new('iins')
    end

    def self.fetch(id)
      request.fetch id
    end
  end
end
