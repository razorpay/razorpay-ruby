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

    def self.update(id, data = {})
      request.patch id, data
    end

    def self.issue(id)
      request.post "#{id}/issue"
    end

    def self.cancel(id)
      request.post "#{id}/cancel"
    end

    def update(data = {})
      self.class.update id, data
    end

    def issue
      self.class.issue(id)
    end

    def cancel
      self.class.cancel(id)
    end

    # no delete
  end
end

__END__


    # Coming Soon
    ##
    def self.charge(id)
      request.post "#{id}/charge"
    end
    def charge
      self.class.charge(id)
    end
