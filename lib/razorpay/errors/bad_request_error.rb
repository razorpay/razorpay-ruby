require 'razorpay/errors/razorpay_error'

module Razorpay
  # Bad request to API. Missing a field or an invalid field.
  # Error in merchant request. Check the description and correct the request accordingly.
  class BadRequestError < Razorpay::Error
    attr_reader :field

    def initialize(code, status, field = nil)
      super(code, status)
      @field = field
    end
  end
end
