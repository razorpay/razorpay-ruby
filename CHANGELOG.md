# Change Log

Changelog for Razorpay-Ruby SDK.

## Unreleased

## [3.2.3] - 2024-05-27

feat: Added new API endpoints
* Added support for `add_bank_account`, `delete_bank_account`, `request_eligibility_check` & `fetch_eligibility` on customer
* Added support for `expand_details` on payment
* Added support for fetch Reversals for a Transfer
* Added support for Dispute
* Added support for Document
* Added support for `view_rto` & `edit_fulfillment` on order

## [3.2.2] - 2024-04-16

feat: Added oauth APIs and support for access token based authentication mechanism
* Added oauth APIs (getAuthURL, getAccessToken, refreshToken, revokeToken)
* Added support for access token based authentication mechanism
* Added support for onboarding signature generation

## [3.2.1] - 2023-12-19

Rollback: Generic access point due to some performance concern

## [3.2.0] - 2023-12-11

feat: Added generic access point

## [3.1.0] - 2023-10-13

### Added

feat: Added new API endpoints

Added account onboarding API create, fetch, edit, delete
Added stakeholders API create, fetch, all, edit
Added product configuration API request_product_configuration, fetch, edit, fetch_tnc
Added webhooks API create, fetch, all, edit, delete
Added Documents API upload_account_doc, fetch_account_doc, upload_stakeholder_doc, fetch_stakeholder_doc
Added token sharing API create, fetch, delete, process_payment_on_alternate_pa_or_pg

## [3.0.1] - 2022-07-11

### Added

- Added Third party validation API for Payments (create_upi, validate_vpa)
- New API for Payment Methods
- Doc Updated

## [3.0.0] - 2022-06-03

### Added

- QR code end point API
- Settlement end point API
- Fund Account end point API
- PaymentLinks end point API
- Item end point API
- New APIs for Invoices (Delete, Send/resend)
- New API for Customers (Fetch Tokens, Delete Token)
- New APIs for Subscriptions (Update, Pause, Resume, Pending update, Delete offer)
- New API for Addons (Fetch all Addons)
- New API for Refund (Update refund)
- New APIs for Payments (Update, Create recurring, Create Json, Payment downtime details, refunds of a payment, Otp generate, Otp submit, Otp resend)
- New APIs for Virtual Account (Add receiver, add an allowed payer account, delete an allowed payer account)
- Updated Testcases
- Updated Readme

## [2.4.1] - 2019-04-09

### Fixed

- Subscription signature verification [[#81][81]]

### Added

- Ruby version to user agent header [[#79][79]]

## [2.4.0] - 2019-04-08

### Changed

- Indexed keys used in x-www-form-urlencoded request bodies [[#68][68]]
- Updated Utility verify\_\* methods to return verification bool [[#72][72]]

### Added

- Support for custom JSON options to Entity to_json [[#75][75]]

## [2.3.0] - 2018-04-20

### Added

- Support for subscription signature verification
- Bang! methods (`capture!`, `refund!`) that update the calling entity

## [2.2.0] - 2018-01-29

### Added

- Support for Subscriptions

## [2.1.0] - 2017-11-17

### Changed

- Generic `Razorpay::Error` is thrown when server is unreachable

### Added

- Support for making raw requests to the API via `raw_request`.

## [2.1.0.pre] - 2017-08-17

### Added

- Support for Virtual Accounts

## [2.0.1] - 2017-07-31

### Fixed

- Webhook signature verification

## [2.0.0] - 2017-03-02

### Added

- Adds `require` for all Razorpay supported entities
- All entity objects now throw `NoMethodError` instead of `NameError` if the attribute doesn't exist
- Adds customer edit API
- Adds card fetch API
- Adds custom header support
- Adds constant time signature verification API for payments and webhooks
- Adds payment capture-without-fetch API
- Enables warnings for tests
- Removes circular `require` calls
- Adds rake test groups

## [1.2.1] - 2016-12-22

### Changed

- Drops ArgumentError checks for local validation. Rely on server side checks instead.

### Added

- Support for customers and invoices API
- Loads Order class by default.

## [1.2.0] - 2016-11-23

### Added

- Fixed payment.method as an attribute accessor

## [1.1.0] - 2016-02-25

### Added

- Add support for Orders API
- Bundles the CA Certificate with the gem. See #6

## [1.0.3] - 2015-03-31

### Changed

- Handles error requests properly

## [1.0.1] - 2015-02-23

### Added

- Added support for ruby versions below 2.0

## [1.0.0] - 2015-01-17

### Added

- Initial Release

# Diff

- [Unreleased](https://github.com/razorpay/razorpay-ruby/compare/2.4.1...HEAD)
- [2.4.1](https://github.com/razorpay/razorpay-ruby/compare/2.4.0...2.4.1)
- [2.4.0](https://github.com/razorpay/razorpay-ruby/compare/2.3.0...2.4.0)
- [2.3.0](https://github.com/razorpay/razorpay-ruby/compare/2.2.0...2.3.0)
- [2.2.0](https://github.com/razorpay/razorpay-ruby/compare/2.1.0...2.2.0)
- [2.1.0](https://github.com/razorpay/razorpay-ruby/compare/2.0.1...2.1.0)
- [2.1.0.pre](https://github.com/razorpay/razorpay-ruby/compare/2.0.1...2.1.0.pre)
- [2.0.1](https://github.com/razorpay/razorpay-ruby/compare/2.0.0...2.0.1)
- [2.0.0](https://github.com/razorpay/razorpay-ruby/compare/1.2.1...2.0.0)
- [1.2.1](https://github.com/razorpay/razorpay-ruby/compare/1.2.0...1.2.1)
- [1.2.0](https://github.com/razorpay/razorpay-ruby/compare/1.1.0...1.2.0)
- [1.1.0](https://github.com/razorpay/razorpay-ruby/compare/1.0.3...1.1.0)
- [1.0.3](https://github.com/razorpay/razorpay-ruby/compare/1.0.1...1.0.3)
- [1.0.1](https://github.com/razorpay/razorpay-ruby/compare/1.0.0...1.0.1)

[68]: https://github.com/razorpay/razorpay-ruby/pull/68
[72]: https://github.com/razorpay/razorpay-ruby/pull/72
[75]: https://github.com/razorpay/razorpay-ruby/pull/75
[79]: https://github.com/razorpay/razorpay-ruby/pull/79
[81]: https://github.com/razorpay/razorpay-ruby/pull/81
