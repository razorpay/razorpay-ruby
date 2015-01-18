# Razorpay Ruby bindings

[![Build Status](https://travis-ci.org/Razorpay/razorpay-ruby.svg?branch=master)](https://travis-ci.org/Razorpay/razorpay-ruby) [![Gem Version](https://badge.fury.io/rb/razorpay.svg)](http://badge.fury.io/rb/razorpay) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

This is the base ruby gem for interacting with the Razorpay API. This is primarily meant for merchants who wish to perform interactions with the Razorpay API programatically.

## Installation

Add this line to your application's Gemfile:

    gem 'razorpay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install razorpay

## Usage

Remember to `require razorpay` before anything else.

Next, you need to setup your key and secret using the following:

    Razorpay.setup("merchant_key_id", "merchant_key_secret")

You can find your API keys at <https://dashboard.razorpay.com/#/app/keys>.

If you are using rails, the right place to do this might be `config/initializers/razorpay.rb`.

The most common construct is capturing a payment, which you do via the following:

    Razorpay::Payment.fetch("pay-ment_id").capture({amount:500})
    # Note that the amount should come from your session, so as to verify
    # that the purchase was correctly done and not tampered

You can handle refunds using the following constructs:

    Razorpay::Payment.fetch("pay-ment_id").refund({amount:500})

For other applications (such as fetching payments and refunds),
see our online documentation on <https://docs.razorpay.com>

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
