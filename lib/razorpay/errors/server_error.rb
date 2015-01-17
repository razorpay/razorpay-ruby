require 'razorpay/errors/razorpay_error'

module Razorpay
  # There is some problem with the server
  class ServerError < Razorpay::Error
  end
end
