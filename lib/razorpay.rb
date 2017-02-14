require 'razorpay/constants'
require 'razorpay/payment'
require 'razorpay/refund'
require 'razorpay/order'
require 'razorpay/customer'
require 'razorpay/invoice'

# Base Razorpay module
module Razorpay
  class << self
    attr_accessor :auth, :custom_headers
  end

  def self.setup(key_id, key_secret)
    self.auth = { username: key_id, password: key_secret }
  end

  def self.set_headers(headers = {})
    self.custom_headers = headers
  end
end
