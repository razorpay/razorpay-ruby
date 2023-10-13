require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Webhook API allows you create, fetch, update and delete
  class Webhook < Entity

    @@versions = "v2"

    def self.request
      Razorpay::Request.new('accounts')
    end

    def self.create(options, account_id = nil)
      if(account_id)
       return request.post "#{account_id}/webhooks", options, @@versions
      end

      r = request
      return r.request :post, "/v1/webhooks", options
    end

    def self.all(options = {}, account_id = nil)
      if(account_id)
       return request.get "#{account_id}/webhooks" , options , @@versions
      end

      r = request
      return r.request :get, "/v1/webhooks", options
    end

    def self.fetch(id, account_id)
      request.fetch "#{account_id}/webhooks/#{id}", @@versions
    end

    def self.edit(options, id, account_id = nil)
      if(account_id)  
       return request.patch "#{account_id}/webhooks/#{id}", options, @@versions
      end

      r = request
      return r.request :put, "/v1/webhooks/#{id}" , options
    end

    def self.delete(id, account_id)
      request.delete "#{account_id}/webhooks/#{id}", @@versions
    end
  end
end

