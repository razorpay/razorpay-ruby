# Version and other constants are defined here
module Razorpay
  BASE_URI = 'https://api.razorpay.com'.freeze
  TEST_URL = 'https://api.razorpay.com/'.freeze
  VERSION = '3.2.0'.freeze
  ENTITIES_LIST =  {
    "cards" => "card",
    "invoices" => "invoice",
    "refunds" => "refund",
    "orders" => "order",
    "payments" => "payment",
    "customers" => "customer",
    "plans" => "plan",
    "virtual_accounts" => "virtualAccount",
    "addons" => "addon",
    "subscriptions" => "subscriptions",
    "subscription_registrations" => "subscription_registrations",
    "transfers" => "transfers",
    "payment_links" => "payment_links",
    "settlements" => "settlements",
    "qr_codes" => "qr_codes",
    "items" => "items",
    "fund_accounts" => "fund_accounts",
    "webhooks" => "webhook",
    "payment_methods" => "payment_methods",
    "products" => "products",
    "tokens" => "tokens",
    "iins" => "iins",
    "stakeholders" => "stakeholders",
    "accounts" => "accounts"
  }
end
