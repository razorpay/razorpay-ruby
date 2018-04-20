require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Invoice API allows you to create and
  # manage invoices with Razorpay
  class Invoice < Entity
    def self.request
      Razorpay::Request.new('invoices')
    end

    def self.create(options)
      request.create options
    end

    def self.fetch(id)
      request.fetch id
    end

    def self.all(options = {})
      request.all options
    end

    def self.edit(id, options = {})
      request.patch id, options
    end

    def self.issue(id)
      request.post "#{id}/issue"
    end

    def self.cancel(id)
      request.post "#{id}/cancel"
    end

    def edit(options = {})
      self.class.edit id, options
    end

    def edit!(options = {})
      with_a_bang { edit options }
    end

    def issue
      self.class.issue id
    end

    def issue!
      with_a_bang { issue }
    end

    def cancel
      self.class.cancel id
    end

    def cancel!
      with_a_bang { cancel }
    end
  end
end
