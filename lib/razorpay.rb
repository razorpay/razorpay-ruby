require 'razorpay/card'
require 'razorpay/order'
require 'razorpay/errors'
require 'razorpay/refund'
require 'razorpay/invoice'
require 'razorpay/payment'
require 'razorpay/utility'
require 'razorpay/customer'
require 'razorpay/constants'
require 'razorpay/collection'
require 'razorpay/virtual_account'
require 'razorpay/plan'
require 'razorpay/subscription'
require 'razorpay/addon'
require 'razorpay/transfer'
require 'razorpay/subscription_registration'
require 'razorpay/settlement'
require 'razorpay/payment_link'
require 'razorpay/fund_account'
require 'razorpay/item'
require 'razorpay/qr_code'
require 'razorpay/payment_method'
require 'razorpay/webhook'
require 'razorpay/iin'
require 'razorpay/token'
require 'razorpay/product'
require 'razorpay/stakeholder'
require 'razorpay/account'
require 'razorpay/document'
require 'razorpay/dispute'
require 'razorpay/oauth_token'

# Base Razorpay module
module Razorpay
  class << self
    attr_accessor :auth, :custom_headers, :access_token, :auth_type
  end

  def self.setup(key_id, key_secret)
    self.auth = { username: key_id, password: key_secret }
    self.auth_type = Razorpay::PRIVATE_AUTH
  end

  def self.setup_with_oauth(access_token)
    self.access_token = access_token
    self.auth_type = Razorpay::OAUTH
  end

  def self.headers=(headers = {})
    self.custom_headers = headers
  end
end
