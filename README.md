# Razorpay Ruby bindings

[![Build Status](https://travis-ci.org/razorpay/razorpay-ruby.svg?branch=master)](https://travis-ci.org/razorpay/razorpay-ruby) [![Gem Version](https://img.shields.io/badge/gem%20version-v3.0.0-dark%20green.svg)](http://badge.fury.io/rb/razorpay) [![Coverage Status](https://coveralls.io/repos/github/Razorpay/razorpay-ruby/badge.svg?branch=master)](https://coveralls.io/github/Razorpay/razorpay-ruby?branch=master) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

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

## Requirements

Ruby 2.6.8 or later
## Usage

Remember to `require 'razorpay'` before anything else.

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

## Supported Resources
- [Customer](documents/customer.md)
- [Token](documents/tokens.md)
- [Order](documents/order.md)
- [Payments](documents/payment.md)
- [Settlements](documents/settlement.md)
- [Fund](documents/fund.md)
- [Refunds](documents/refund.md)
- [Invoice](documents/Invoice.md)
- [Plan](documents/plan.md)
- [Item](documents/items.md)
- [Subscriptions](documents/subscriptions.md)
- [Add-on](documents/addon.md)
- [Payment Links](documents/paymentLink.md)
- [Smart Collect](documents/virtualAccount.md)
- [Transfer](documents/transfers.md)
- [QR Code](documents/qrcode.md)
- [Emandate](documents/emandate.md)
- [Cards](documents/card.md)
- [Paper NACH](documents/papernach.md)
- [UPI](documents/upi.md)
- [Register Emandate and Charge First Payment Together](documents/registerEmandate.md)
- [Register NACH and Charge First Payment Together](documents/registerNach.md)
- [Payment Verification](documents/paymentVerification.md)
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
