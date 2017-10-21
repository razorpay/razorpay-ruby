module Razorpay
  # Default Error class for any unknown errors
  class Error < StandardError
    attr_reader :code, :status

    def initialize(code = nil, status = nil)
      @code = code
      @status = status
    end
  end
end
