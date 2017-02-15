require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Card API allows you to fetch cards
  # saved with Razorpay
  # Docs: https://docs.razorpay.com/v1/page/cards
  class Card < Entity
    def self.request
      Razorpay::Request.new('cards')
    end

    def self.fetch(id)
      request.fetch id
    end
  end
end
