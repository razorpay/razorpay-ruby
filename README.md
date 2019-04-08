# Razorpay Ruby bindings

[![Build Status](https://travis-ci.org/razorpay/razorpay-ruby.svg?branch=master)](https://travis-ci.org/razorpay/razorpay-ruby) [![Gem Version](https://badge.fury.io/rb/razorpay.svg)](http://badge.fury.io/rb/razorpay) [![Coverage Status](https://coveralls.io/repos/github/Razorpay/razorpay-ruby/badge.svg?branch=master)](https://coveralls.io/github/Razorpay/razorpay-ruby?branch=master) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

This is the base ruby gem for interacting with the Razorpay API. This is primarily meant for users who wish to perform interactions with the Razorpay API programatically.

## Installation

Add this line to your application's Gemfile:

```rb
gem 'razorpay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install razorpay

## Usage

Remember to `require razorpay` before anything else.

Next, you need to setup your key and secret using the following:

```rb
Razorpay.setup('key_id', 'key_secret')
```

You can set customer headers for your requests using the following:
```rb
Razorpay.headers = {"CUSTOM_APP_HEADER" => "CUSTOM_VALUE"}
```

You can find your API keys at <https://dashboard.razorpay.com/#/app/keys>.

If you are using rails, the right place to do this might be `config/initializers/razorpay.rb`.

The most common construct is capturing a payment, which you do via the following:

```rb
Razorpay::Payment.fetch("payment_id").capture({amount:500})
# Note that the amount should come from your session, so as to verify
# that the purchase was correctly done and not tampered
```

You can refund a payment via the following:

```rb
Razorpay::Payment.fetch("payment_id").refund({amount:500})
refunds = Razorpay::Payment.fetch("payment_id").refunds
```

A payment can also be refunded without fetching it:
```rb
refund = Razorpay::Refund.create(payment_id:"payment_id")
Razorpay::Refund.fetch(refund.id)
```

If payment is captured or refunded via `capture!` or `refund!`, then the calling object is also updated:
```rb
payment = Razorpay::Payment.fetch('payment_id')
payment.status
# 'authorized'
payment.capture!
payment.status
# 'captured'
payment.refund!
payment.status
# 'refunded'
```

For other applications (such as fetching payments and refunds),
see our online documentation on <https://docs.razorpay.com>

### Orders API

You can use the orders API using the following constructs:

You can find docs at <https://docs.razorpay.com/v1/page/orders>

```rb
order = Razorpay::Order.create amount: 5000, currency: 'INR', receipt: 'TEST'
# order.id = order_50sX9hGHZJvjjI

# Same collection as Refunds or Payments
orders = Razorpay::Order.all

# Fetching an Order
order = Razorpay::Order.fetch('order_50sX9hGHZJvjjI')
puts order.amount

# Fetching payments corresponding to an order
payments = order.payments
```

### Verification
You can use the Utility class to verify the signature received in response to a payment made using Orders API
```rb
puts payment_response
# {
#   :razorpay_order_id   => "fake_order_id",
#   :razorpay_payment_id => "fake_payment_id",
#   :razorpay_signature  => "signature"
# }
Razorpay::Utility.verify_payment_signature(payment_response)
```
You can also [verify the signature](https://github.com/razorpay/razorpay-ruby/wiki/Webhooks) received in a webhook:
```rb
Razorpay::Utility.verify_webhook_signature(webhook_body, webhook_signature, webhook_secret)
```

### Customers
```rb
# Create a customer
customer = Razorpay::Customer.create email: 'test@razorpay.com', contact: '9876543210'
puts customer.id #cust_6vRXClWqnLhV14
```

### Cards
```rb
# Fetch a card
card = Razorpay::Card.fetch('card_7EZLhWkDt05n7V')
puts card.network #VISA
```

You can find cards API documentation at <https://docs.razorpay.com/v1/page/cards>.

### Invoices
```rb
# Creating an invoice
invoice = Razorpay::Invoice.create customer_id: customer.id, amount: 100, currency: 'INR', description: 'Test description', type: 'link'
```

You can find invoices API documentation at <https://docs.razorpay.com/v1/page/invoices>.

### Plan
```rb
# Creating a plan
plan = Razorpay::Plan.create interval: 1, period: 'monthly', item: { name: 'fake_plan', description: 'fake_desc', currency: 'INR', amount: 500 }, notes: { identifier: 'plan_monthly_super' }
```

You can find plan API documentation at <https://razorpay.com/docs/subscriptions/api/#plan>.

### Subscription
```rb
# Creating a subscription and starting after 24 hours (24 hours = 60 * 60 * 24)
subscription = Razorpay::Subscription.create plan_id: plan.id, customer_id: customer.id, start_at: (Time.now + (60 * 60 * 24)).to_i, total_count: 3
```

You can find subscription API documentation at <https://razorpay.com/docs/subscriptions/api/#subscription>.

### Addon
```rb
# Creating an addon
subscription_addon = Razorpay::Addon.create subscription.id, item: { name: 'fake_plan', description: 'fake_desc', currency: 'INR', amount: 500 }, quantity: 1

# Fetching an addon
addon = Razorpay::Addon.fetch subscription_addon.id
```

You can find addon API documentation at <https://razorpay.com/docs/subscriptions/api/#add-on>.

## Development

- Everything is namespaced under the Razorpay module
- We use rubocop for checking style guidelines
- Rake + MiniTest is using as the testrunner
- Webmock is used as the request mock framework
- HTTParty is used for making requests
- Travis is used for CI
- Coveralls is used for coverage reports

## Contributing

1. Fork it ( https://github.com/razorpay/razorpay-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run `rake` and `rubocop` after making your changes to make sure you didn't break anything
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## Supported Versions

While we support [all currently supported versions of Ruby](https://www.ruby-lang.org/en/downloads/branches/)
only, the code is tested against the following versions:

* 1.9.3
* 2.0.0
* 2.1.10
* 2.3.8
* 2.4.6
* 2.5.5
* 2.6.2

## Release

Steps to follow for a release:

0. Merge the branch with the new code to master.
1. Bump the Version in `lib/razorpay/constants.rb`
2. Rename Unreleased to the new tag in `CHANGELOG`
3. Fix links at bottom in `CHANGELOG`
4. Commit (message should include version number)
5. Tag the release and push to GitHub. Get the tag signed using Razorpay GPG key.
6. Create a release on GitHub using the website with more details about the release
7. Run `gem build razorpay-ruby.gemspec`
8. Run `gem push razorpay-{version}.gem`

`gem push` will ask you for credentials, if you are not logged in already.
