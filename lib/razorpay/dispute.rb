require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  class Dispute < Entity
    def self.request
      Razorpay::Request.new('disputes')
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.all(options = {})
       request.all options
    end

    def self.accept(id, options={})
       request.post "#{id}/accept", options
    end

    def self.contest(id, options)
       request.patch "#{id}/contest", options
    end
  end
end
