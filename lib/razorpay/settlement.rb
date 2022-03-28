require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Settlement API allows you to fetch and delete
  # Docs: https://razorpay.com/docs/api/settlements/
  class Settlement < Entity
    def self.request
      Razorpay::Request.new('settlements')
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.reports(options={})
      request.get "recon/combined", options
    end

    def self.all(options = {})
      request.all options
    end

    def self.create(options={})
     
      if(!options.is_a?(String) && options.key?(:settle_full_balance))
        options[:settle_full_balance] = (options[:settle_full_balance] ? 1 : 0)
      end 
      request.post "ondemand", options
    end

    def self.fetchAllOndemandSettlement(options={})
      request.get "ondemand", options
    end

    def fetchOndemandSettlementById
      self.class.request.get "ondemand/#{id}"
    end
  end
end
