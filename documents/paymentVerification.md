## payment verification

```rb
require "razorpay"
Razorpay.setup('key_id', 'key_secret')
```

### Verify payment verification

```rb
payment_response = {
        razorpay_order_id: 'order_IEIaMR65cu6nz3',
        razorpay_payment_id: 'pay_IH4NVgf4Dreq1l',
        razorpay_signature: '0d4e745a1838664ad6c9c9902212a32d627d68e917290b0ad5f08ff4561bc50f'
      }
Razorpay::Utility.verify_payment_signature(payment_response)
```

**Parameters:**


| Name  | Type      | Description                                      |
|-------|-----------|--------------------------------------------------|
| razorpay_order_id*  | string | The id of the order to be fetched  |
| razorpay_payment_id*    | string | The id of the payment to be fetched |
| razorpay_signature* | string   | Signature returned by the Checkout. This is used to verify the payment. |

-------------------------------------------------------------------------------------------------------
### Verify subscription verification

```rb
payment_response = {
        razorpay_order_id: 'pay_IDZNwZZFtnjyym',
        razorpay_payment_id: 'sub_ID6MOhgkcoHj9I',
        razorpay_signature: '601f383334975c714c91a7d97dd723eb56520318355863dcf3821c0d07a17693'
      }
Razorpay::Utility.verify_payment_signature(payment_response)
```

**Parameters:**


| Name  | Type      | Description                                      |
|-------|-----------|--------------------------------------------------|
| razorpay_order_id*  | string | The id of the subscription to be fetched  |
| razorpay_payment_id*    | string | The id of the payment to be fetched |
| razorpay_signature* | string   | Signature returned by the Checkout. This is used to verify the payment. |

-------------------------------------------------------------------------------------------------------
### Verify paymentlink verification

```rb
payment_response = {
  payment_link_id: 'plink_IH3cNucfVEgV68',
  payment_link_reference_id: 'TSsd1989',
  payment_link_status: 'paid',
  razorpay_payment_id: 'pay_IH3d0ara9bSsjQ',
  razorpay_signature: 'b8a6acda585c9b74e9da393c7354c7e685e37e69d30ae654730f042e674e0283'
}
Razorpay::Utility.verify_payment_link_signature(payment_response)
```

**Parameters:**


| Name  | Type      | Description                                      |
|-------|-----------|--------------------------------------------------|
| razorpayPaymentlinkId*  | string | The id of the paymentlink to be fetched  |
| razorpayPaymentId*  | string | The id of the payment to be fetched  |
| razorpayPaymentLinkReferenceId*  | string |  A reference number tagged to a Payment Link |
| razorpayPaymentLinkStatus*  | string | Current status of the link  |
| signature* | string   | Signature returned by the Checkout. This is used to verify the payment. |
| secret* | string   | your api secret as secret |

-------------------------------------------------------------------------------------------------------

**PN: * indicates mandatory fields**
<br>
<br>