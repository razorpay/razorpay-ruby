require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
  # Invoice API allows you to create and
  # manage invoices with Razorpay
  class Invoice < Entity
    def create(options)
      request.create options
    end

    def fetch(id)
      request.fetch id
    end

    def all(options = {})
      request.all options
    end

    def edit_with_id(id, options = {})
      request.patch id, options
    end

    def issue_with_id(id)
      request.post "#{id}/issue"
    end

    def cancel_with_id(id)
      request.post "#{id}/cancel"
    end

    def edit(options = {})
      edit_with_id id, options
    end

    def edit!(options = {})
      with_a_bang { edit options }
    end

    def issue
      issue_with_id id
    end

    def issue!
      with_a_bang { issue }
    end

    def cancel
      cancel_with_id id
    end

    def cancel!
      with_a_bang { cancel }
    end
  end
end
