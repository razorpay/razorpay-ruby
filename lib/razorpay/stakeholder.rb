require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Stakeholder API allows you to add stakeholders for an account. 
  class Stakeholder < Entity

    @@versions = "v2"

    def self.request
      Razorpay::Request.new('accounts')
    end

    def self.create(account_id, options)
      request.post "#{account_id}/stakeholders", options, @@versions
    end

    def self.fetch(account_id, id)
      request.fetch "#{account_id}/stakeholders/#{id}", @@versions
    end

    def self.all(account_id)
      request.get "#{account_id}/stakeholders",{}, @@versions
    end   

    def self.edit(account_id, id, options = {})
      request.patch "#{account_id}/stakeholders/#{id}", options, @@versions
    end

    def self.upload_stakeholder_doc(account_id, id,options)
      r = request
      r.request :post, "/#{@@versions}/accounts/#{account_id}/stakeholders/#{id}/documents", options
    end

    def self.fetch_stakeholder_doc(account_id, id)
      request.fetch "#{account_id}/stakeholders/#{id}/documents", @@versions
    end
  end
end
