## Payments

```rb
require "razorpay"

Razorpay.setup('key_id', 'key_secret')
```

### Capture payment

```rb
paymentId = "pay_G8VQzjPLoAvm6D"

para_attr = {
    "amount": 1000,
    "currency": "INR"
}
Razorpay::Payment.capture(paymentId, para_attr)
```

**Parameters:**

| Name      | Type    | Description                                                                    |
|-----------|---------|--------------------------------------------------------------------------------|
| paymentId* | string  | Id of the payment to capture                                                   |
| para_attr    | object | All parameters listed [here](https://razorpay.com/docs/api/payments/#capture-a-payment) are supported  |

**Response:**
```json
{
  "id": "pay_G8VQzjPLoAvm6D",
  "entity": "payment",
  "amount": 1000,
  "currency": "INR",
  "status": "captured",
  "order_id": "order_G8VPOayFxWEU28",
  "invoice_id": null,
  "international": false,
  "method": "upi",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": true,
  "description": "Purchase Shoes",
  "card_id": null,
  "bank": null,
  "wallet": null,
  "vpa": "gaurav.kumar@exampleupi",
  "email": "gaurav.kumar@example.com",
  "contact": "+919999999999",
  "customer_id": "cust_DitrYCFtCIokBO",
  "notes": [],
  "fee": 24,
  "tax": 4,
  "error_code": null,
  "error_description": null,
  "error_source": null,
  "error_step": null,
  "error_reason": null,
  "acquirer_data": {
    "rrn": "033814379298"
  },
  "created_at": 1606985209
}
```
-------------------------------------------------------------------------------------------------------

### Fetch all payments

```rb
option = {"count":1}

Razorpay::Payment.all(option)
```

**Parameters:**

| Name  | Type      | Description                                      |
|-------|-----------|--------------------------------------------------|
| from  | timestamp | timestamp after which the payments were created  |
| to    | timestamp | timestamp before which the payments were created |
| count | integer   | number of payments to fetch (default: 10)        |
| skip  | integer   | number of payments to be skipped (default: 0)    |
| expand[]  | string   | Supported values are: -card: Expanded card details, usable for card and EMI payments. -emi: Expanded EMI plan details, usable for EMI payments    |


**Response:**
```json
{
  "entity": "collection",
  "count": 2,
  "items": [
    {
      "id": "pay_G8VaL2Z68LRtDs",
      "entity": "payment",
      "amount": 900,
      "currency": "INR",
      "status": "captured",
      "order_id": "order_G8VXfKDWDEOHHd",
      "invoice_id": null,
      "international": false,
      "method": "netbanking",
      "amount_refunded": 0,
      "refund_status": null,
      "captured": true,
      "description": "Purchase Shoes",
      "card_id": null,
      "bank": "KKBK",
      "wallet": null,
      "vpa": null,
      "email": "gaurav.kumar@example.com",
      "contact": "+919999999999",
      "customer_id": "cust_DitrYCFtCIokBO",
      "notes": [],
      "fee": 22,
      "tax": 4,
      "error_code": null,
      "error_description": null,
      "error_source": null,
      "error_step": null,
      "error_reason": null,
      "acquirer_data": {
        "bank_transaction_id": "0125836177"
      },
      "created_at": 1606985740
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### Fetch a payment

```rb
paymentId = "pay_G8VQzjPLoAvm6D"

Razorpay::Payment.fetch(paymentId)
```

**Parameters:**

| Name       | Type   | Description                       |
|------------|--------|-----------------------------------|
| paymentId* | string | Id of the payment to be retrieved |

**Response:**
```json
{
  "id": "pay_G8VQzjPLoAvm6D",
  "entity": "payment",
  "amount": 1000,
  "currency": "INR",
  "status": "captured",
  "order_id": "order_G8VPOayFxWEU28",
  "invoice_id": null,
  "international": false,
  "method": "upi",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": true,
  "description": "Purchase Shoes",
  "card_id": null,
  "bank": null,
  "wallet": null,
  "vpa": "gaurav.kumar@exampleupi",
  "email": "gaurav.kumar@example.com",
  "contact": "+919999999999",
  "customer_id": "cust_DitrYCFtCIokBO",
  "notes": [],
  "fee": 24,
  "tax": 4,
  "error_code": null,
  "error_description": null,
  "error_source": null,
  "error_step": null,
  "error_reason": null,
  "acquirer_data": {
    "rrn": "033814379298"
  },
  "created_at": 1606985209
}
```
-------------------------------------------------------------------------------------------------------

### Fetch payments for an order

```rb
orderId = "order_DovFx48wjYEr2I"

Razorpay::Order.fetch(orderId).payments
```
**Parameters**

| Name     | Type   | Description                         |
|----------|--------|-------------------------------------|
| orderId* | string | The id of the order to be retrieve payment info |

**Response:**
```json
{
  "count": 1,
  "entity": "collection",
  "items": [
    {
      "id": "pay_DovGQXOkPBJjjU",
      "entity": "payment",
      "amount": 600,
      "currency": "INR",
      "status": "captured",
      "order_id": "order_DovFx48wjYEr2I",
      "method": "netbanking",
      "amount_refunded": 0,
      "refund_status": null,
      "captured": true,
      "description": "A Wild Sheep Chase is a novel by Japanese author Haruki Murakami",
      "card_id": null,
      "bank": "SBIN",
      "wallet": null,
      "vpa": null,
      "email": "gaurav.kumar@example.com",
      "contact": "9364591752",
      "fee": 70,
      "tax": 10,
      "error_code": null,
      "error_description": null,
      "error_source": null,
      "error_step": null,
      "error_reason": null,
      "notes": [],
      "acquirer_data": {
        "bank_transaction_id": "0125836177"
      },
      "created_at": 1400826750
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### Update a payment

```rb
paymentId = "pay_CBYy6tLmJTzn3Q"

para_attr = {
	"notes": {
		"key1": "value1",
		"key2": "value2"
	}
}
Razorpay::Payment.fetch(paymentId).edit(para_attr)
```

**Parameters:**

| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| paymentId* | string  | Id of the payment to update           |
| notes*       | object  | A key-value pair                    |

**Response:**
```json
{
  "id": "pay_CBYy6tLmJTzn3Q",
  "entity": "payment",
  "amount": 1000,
  "currency": "INR",
  "status": "authorized",
  "order_id": null,
  "invoice_id": null,
  "international": false,
  "method": "netbanking",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": false,
  "description": null,
  "card_id": null,
  "bank": "UTIB",
  "wallet": null,
  "vpa": null,
  "email": "testme@acme.com",
  "notes": {
    "key1": "value1",
    "key2": "value2"
  },
  "fee": null,
  "tax": null,
  "error_code": null,
  "error_description": null,
  "error_source": null,
  "error_step": null,
  "error_reason": null,
  "acquirer_data": {
    "bank_transaction_id": "0125836177"
  },
  "created_at": 1553504328
}
```
-------------------------------------------------------------------------------------------------------

### Fetch expanded card or emi details for payments

Request #1: Card

```rb
Razorpay::Payment.all({'expand[]':'card'})
```

Request #2: EMI

```rb
Razorpay::Payment.all({'expand[]':'emi'})
```

**Response:**<br>
For expanded card or emi details for payments response please click [here](https://razorpay.com/docs/api/payments/#fetch-expanded-card-or-emi-details-for-payments)

-------------------------------------------------------------------------------------------------------

### Fetch card details with paymentId

```rb
Razorpay::Payment.fetch_card_details(paymentId)
```

**Parameters:**

| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| paymentId* | string  | Id of the payment to update          |

**Response:**
```json
{
  "id": "card_6krZ6bcjoeqyV9",
  "entity": "card",
  "name": "Gaurav",
  "last4": "3335",
  "network": "Visa",
  "type": "debit",
  "issuer": "SBIN",
  "international": false,
  "emi": null,
  "sub_type": "business"
}
```
-------------------------------------------------------------------------------------------------------

### Fetch Payment Downtime Details

```rb
Razorpay::Payment.fetch_payment_downtime
```
**Response:** <br>
For payment downtime response please click [here](https://razorpay.com/docs/api/payments/downtime/#fetch-payment-downtime-details)

-------------------------------------------------------------------------------------------------------

### Fetch Payment Downtime

```rb
downtimeId = "down_F1cxDoHWD4fkQt"

Razorpay::Payment.fetch_payment_downtime_by_id(downtimeId)
```

**Parameters:**

| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| downtimeId* | string  | Id to fetch payment downtime         |

**Response:** <br>
For payment downtime by id response please click [here](https://razorpay.com/docs/api/payments/downtime/#fetch-payment-downtime-details-by-id)

-------------------------------------------------------------------------------------------------------

### Payment capture settings API

```rb
para_attr = {
  "amount":50000,
  "currency": "INR",
  "receipt": "rcptid_11",
  "payment": {
    "capture": "automatic",
    "capture_options": {
      "automatic_expiry_period": 12,
      "manual_expiry_period": 7200,
      "refund_speed": "optimum"
    }  
  }
}
Razorpay::Order.create(para_attr)
```

**Parameters:**

| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| amount*          | integer | Amount of the order to be paid                                               |
| currency*        | string  | Currency of the order. Currently only `INR` is supported.       |
| receipt         | string  | Your system order reference id.                                              |
| payment         | object  | please refer this [doc](https://razorpay.com/docs/payments/payments/capture-settings/api/) for params  |
| notes | object  | A key-value pair  |

**Response:** <br>
```json
{
  "id": "order_DBJOWzybf0sJbb",
  "entity": "order",
  "amount": 50000,
  "amount_paid": 0,
  "amount_due": 50000,
  "currency": "INR",
  "receipt": "rcptid_11",
  "status": "created",
  "attempts": 0,
  "notes": [],
  "created_at": 1566986570
}
```
-------------------------------------------------------------------------------------------------------

### Create a Recurring Payment

```rb
para_attr = {
  "email": "gaurav.kumar@example.com",
  "contact": "9123456789",
  "amount": 1000,
  "currency": "INR",
  "order_id": "order_1Aa00000000002",
  "customer_id": "cust_1Aa00000000001",
  "token": "token_1Aa00000000001",
  "recurring": "1",
  "description": "Creating recurring payment for Gaurav Kumar",
  "notes": {
    "note_key 1": "Beam me up Scotty",
    "note_key 2": "Tea. Earl Gray. Hot."
  }
}
Razorpay::Payment.create_recurring_payment(para_attr)
```

**Parameters:**

| Name            | Type    | Description                                                                  |
|-----------------|---------|------------------------------------------------------------------------------|
| email*          | string | The customer's email address.                                               |
| contact*        | string  | The customer's phone number.                      |
| amount*         | integer  | The amount you want to charge your customer. This should be the same as the amount in the order.                        |
| currency*        | string  | The 3-letter ISO currency code for the payment. Currently, only `INR` is supported. |
| order_id*        | string  | The unique identifier of the order created. |
| customer_id*        | string  | The `customer_id` for the customer you want to charge.  |
| token*        | string  | The `token_id` generated when the customer successfully completes the authorization payment. Different payment instruments for the same customer have different `token_id`.|
| recurring*        | string  | Determines if recurring payment is enabled or not. Possible values:<br>* `1` - Recurring is enabled.* `0` - Recurring is not enabled.|
| description*        | string  | A user-entered description for the payment.|
| notes*        | object  | Key-value pair that can be used to store additional information about the entity. Maximum 15 key-value pairs, 256 characters (maximum) each. |

**Response:**
```json
{
  "razorpay_payment_id" : "pay_1Aa00000000001",
  "razorpay_order_id" : "order_1Aa00000000001",
  "razorpay_signature" : "9ef4dffbfd84f1318f6739a3ce19f9d85851857ae648f114332d8401e0949a3d"
}
```
-------------------------------------------------------------------------------------------------------

### Create Payment Json

```rb
para_attr = {
  "amount": 100,
  "currency": "INR",
  "order_id": "order_EAkbvXiCJlwhHR",
  "email": "gaurav.kumar@example.com",
  "contact": 9090909090,
  "method": "card",
  "card":{
    "number": 4111111111111111,
    "name": "Gaurav",
    "expiry_month": 11,
    "expiry_year": 23,
    "cvv": 100
  }
}

Razorpay::Payment.create_json_payment(para_attr)
```
**Parameters:**
| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| amount*          | integer | Amount of the order to be paid  |
| currency*   | string  | The currency of the payment (defaults to INR)                                  |
| order_id*        | string  | The unique identifier of the order created. |
| email*        | string      | Email of the customer                       |
| contact*      | string      | Contact number of the customer              |
| method*      | string  | Possible value is `card`, `netbanking`, `wallet`,`emi`, `upi`, `cardless_emi`, `paylater`.  |
| card      | object      | All keys listed [here](https://razorpay.com/docs/payments/payment-gateway/s2s-integration/payment-methods/#supported-payment-fields) are supported  |
| bank      | string      | Bank code of the bank used for the payment. Required if the method is `netbanking`.|
| bank_account | object      | All keys listed [here](https://razorpay.com/docs/payments/customers/customer-fund-account-api/#create-a-fund-account) are supported |
| vpa      | string      | Virtual payment address of the customer. Required if the method is `upi`. |
| wallet | string      | Wallet code for the wallet used for the payment. Required if the method is `wallet`. |
| notes | object  | A key-value pair  |

 please refer this [doc](https://razorpay.com/docs/payment-gateway/s2s-integration/payment-methods/) for params

**Response:** <br>
```json
{
  "razorpay_payment_id": "pay_FVmAstJWfsD3SO",
  "next": [
    {
      "action": "redirect",
      "url": "https://api.razorpay.com/v1/payments/FVmAtLUe9XZSGM/authorize"
    },
    {
      "action": "otp_generate",
      "url": "https://api.razorpay.com/v1/payments/pay_FVmAstJWfsD3SO/otp_generate?track_id=FVmAtLUe9XZSGM&key_id=<YOUR_KEY_ID>"
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### OTP Generate

```rb
#Use Only razorpay key
Razorpay.setup("key", "") 

paymentId = "pay_FVmAstJWfsD3SO";

Razorpay::Payment.otp_generate(paymentId)
```

**Parameters:**
| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| paymentId*    | integer | Unique identifier of the payment                                               |
**Response:** <br>
```json
{
 "razorpay_payment_id": "pay_FVmAstJWfsD3SO",
 "next": [
  {
   "action": "otp_submit",
   "url": "https://api.razorpay.com/v1/payments/pay_FVmAstJWfsD3SO/otp_submit/ac2d415a8be7595de09a24b41661729fd9028fdc?key_id=<YOUR_KEY_ID>"
  },
  {
   "action": "otp_resend",
   "url": "https://api.razorpay.com/v1/payments/pay_FVmAstJWfsD3SO/otp_resend/json?key_id=<YOUR_KEY_ID>"
  }
 ],
 "metadata": {
  "issuer": "HDFC",
  "network": "MC",
  "last4": "1111",
  "iin": "411111"
 }
}
```
-------------------------------------------------------------------------------------------------------
### OTP Submit
```rb
para_attr = {
  "otp": "123456"
}

paymentId = "pay_FVmAstJWfsD3SO";

Razorpay::Payment.otp_generate(paymentId, para_attr)
```
**Parameters:**

| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| paymentId*    | integer | Unique identifier of the payment  |
| otp*    | string | The customer receives the OTP using their preferred notification medium - SMS or email |

**Response:** <br>
Success
```json
{
 "razorpay_payment_id": "pay_D5jmY2H6vC7Cy3",
 "razorpay_order_id": "order_9A33XWu170gUtm",
 "razorpay_signature": "9ef4dffbfd84f1318f6739a3ce19f9d85851857ae648f114332d8401e0949a3d"
}
```
Failure
```json
{
  "error": {
    "code" : "BAD_REQUEST_ERROR",
    "description": "payment processing failed because of incorrect otp"
  },
  "next": ["otp_submit", "otp_resend"]
}
```
-------------------------------------------------------------------------------------------------------

### OTP Resend

```rb
paymentId = "pay_FVmAstJWfsD3SO";

Razorpay::Payment.otp_resend(paymentId)
```

**Parameters:**

| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| paymentId*    | integer | Unique identifier of the payment                                               |

Doc reference [doc](https://razorpay.com/docs/payments/payment-methods/cards/authentication/native-otp/#otp-resend)

**Response:** <br>

```json
{
  "next": [
    "otp_submit",
    "otp_resend"
  ],
  "razorpay_payment_id": "pay_JWaNvYmrx75sXo"
}
```

-------------------------------------------------------------------------------------------------------

### Create Payment Json (Third party validation)

```rb
param_attr = {
  "amount": "100",
  "currency": "INR",
  "email": "gaurav.kumar@example.com",
  "contact": "9123456789",
  "order_id": "order_JkVtS9XJdk2u0B",
  "method": "netbanking",
  "bank": "HDFC"
}

Razorpay::Payment.create_json_payment(param_attr)

```

**Parameters:**
| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| amount*          | integer | Amount of the order to be paid  |
| currency*   | string  | The currency of the payment (defaults to INR)                                  |
| order_id*        | string  | The unique identifier of the order created. |
| email*        | string      | Email of the customer                       |
| contact*      | string      | Contact number of the customer              |
| method*      | string  | Possible value is `netbanking` |
| bank*      | string      | The customer's bank code.For example, `HDFC`.|

 please refer this [doc](https://razorpay.com/docs/payments/third-party-validation/s2s-integration/netbanking#step-3-create-a-payment) for params

**Response:** <br>
```json
{
  "razorpay_payment_id": "pay_GAWOYqPlvrtPSi",
  "next": [
    {
      "action": "redirect",
      "url": "https://api.razorpay.com/v1/payments/pay_GAWOYqPlvrtPSi/authorize"
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------
### Create Payment UPI s2s / VPA token (Third party validation)

```rb
para_attr = {
  "amount": 200,
  "currency": "INR",
  "order_id": "order_GAWRjlWkVcRh0V",
  "email": "gaurav.kumar@example.com",
  "contact": "9123456789",
  "method": "upi",
  "customer_id": "cust_EIW4T2etiweBmG",
  "save": 1,
  "ip": "192.168.0.103",
  "referer": "http",
  "user_agent": "Mozilla/5.0",
  "description": "Test flow",
  "notes": {
    "note_key": "value1"
  },
  "upi": {
    "flow": "collect",
    "vpa": "gauravkumar@exampleupi",
    "expiry_time": 5
  }
}

Razorpay::Payment.create_upi(para_attr)
```

**Parameters:**
| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| amount*          | integer | Amount of the order to be paid  |
| currency*   | string  | The currency of the payment (defaults to INR)                                  |
| order_id*        | string  | The unique identifier of the order created. |
| email*        | string      | Email of the customer                       |
| customer_id*   | string      | The id of the customer to be fetched |
| contact*      | string      | Contact number of the customer              |
| notes | array  | A key-value pair  |
| description | string  | Descriptive text of the payment. |
| save | boolean  |  Specifies if the VPA should be stored as tokens.Possible value is `0`, `1`  |
| callback_url   | string      | URL where Razorpay will submit the final payment status. |
| ip*   | string      | The client's browser IP address. For example `117.217.74.98` |
| referer*   | string      | Value of `referer` header passed by the client's browser. For example, `https://example.com/` |
| user_agent*   | string      | Value of `user_agent` header passed by the client's browser. For example, `Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36` |
| upi* (for Upi only)  | array      | All keys listed [here](https://razorpay.com/docs/payments/third-party-validation/s2s-integration/upi/collect#step-14-initiate-a-payment) are supported  |

**Response:** <br>
```json
{
  "razorpay_payment_id": "pay_EAm09NKReXi2e0"
}
```
-------------------------------------------------------------------------------------------------------
### Create Payment UPI s2s / VPA token (Third party validation)

```rb
para_attr = {
    "amount": 100,
    "currency": "INR",
    "order_id": "order_Ee0biRtLOqzRjP",
    "email": "gaurav.kumar@example.com",
    "contact": "9090909090",
    "method": "upi",
    "ip": "192.168.0.103",
    "referer": "http",
    "user_agent": "Mozilla/5.0",
    "description": "Test flow",
    "notes": {
      "purpose": "UPI test payment"
    },
    "upi": {
      "flow": "intent"
    }
}

Razorpay::Payment.create_upi(para_attr)
```

**Parameters:**
| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| amount*          | integer | Amount of the order to be paid  |
| currency*   | string  | The currency of the payment (defaults to INR)                                  |
| order_id*        | string  | The unique identifier of the order created. |
| email*        | string      | Email of the customer                       |
| customer_id*   | string      | The id of the customer to be fetched |
| contact*      | string      | Contact number of the customer              |
| notes | array  | A key-value pair  |
| description | string  | Descriptive text of the payment. |
| save | boolean  |  Specifies if the VPA should be stored as tokens.Possible value is `0`, `1`  |
| callback_url   | string      | URL where Razorpay will submit the final payment status. |
| ip*   | string      | The client's browser IP address. For example `117.217.74.98` |
| referer*   | string      | Value of `referer` header passed by the client's browser. For example, `https://example.com/` |
| user_agent*   | string      | Value of `user_agent` header passed by the client's browser. For example, `Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36` |
| upi* (for Upi only)  | array      | All keys listed [here](https://razorpay.com/docs/payments/third-party-validation/s2s-integration/upi/intent/#step-2-initiate-a-payment) are supported  |

**Response:** <br>
```json
{
  "razorpay_payment_id": "pay_CMeM6XvOPGFiF",
  "link": "upi://pay?pa=success@razorpay&pn=xyz&tr=xxxxxxxxxxx&tn=gourav&am=1&cu=INR&mc=xyzw"
}
```
-------------------------------------------------------------------------------------------------------

### Valid VPA (Third party validation)

```rb
para_attr = {
  "vpa": "gauravkumar@exampleupi"
}
Razorpay::Payment.validate_vpa(para_attr)
```

**Parameters:**
| Name        | Type    | Description                          |
|-------------|---------|--------------------------------------|
| vpa*          | string | The virtual payment address (VPA) you want to validate. For example,   `gauravkumar@exampleupi`  |

 please refer this [doc](https://razorpay.com/docs/payments/third-party-validation/s2s-integration/upi/collect#step-13-validate-the-vpa) for params

**Response:** <br>
```json
{
  "vpa": "gauravkumar@exampleupi",
  "success": true,
  "customer_name": "Gaurav Kumar"
}
```
-------------------------------------------------------------------------------------------------------

### Fetch payment methods (Third party validation)

```rb
Razorpay.setup('key', '') # Use Only razorpay key

Razorpay::PaymentMethods.all()
```

**Response:** <br>
 please refer this [doc](https://razorpay.com/docs/payments/third-party-validation/s2s-integration/methods-api/#fetch-payment-methods) for response


-------------------------------------------------------------------------------------------------------

### Token IIN API

```rb
tokenIin = "412345";

Razorpay::Iin.fetch(tokenIin);
```

**Parameters:**

| Name       | Type   | Description                       |
|------------|--------|-----------------------------------|
| tokenIin* | string | The token IIN. |

**Response:**
```json
{
  "iin": "412345",
  "entity": "iin",
  "network": "Visa",
  "type": "credit",
  "sub_type": "business",
  "issuer_code": "HDFC",
  "issuer_name": "HDFC Bank Ltd",
  "international": false,
  "is_tokenized": true,
  "card_iin": "411111",
  "emi":{
     "available": true
     },
  "recurring": {
     "available": true
     },
  "authentication_types": [
   {
       "type":"3ds"
   },
   {
       "type":"otp"
   }
  ]
}
```
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

### Fetch a Payment (With Expanded EMI Details)

```rb
Razorpay::Payment.expand_details("pay_XXXXXXXXXXXXXX",{"expand[]": "emi"})
```

**Parameters:**

| Name        | Type    | Description                                                      |
|-------------|---------|------------------------------------------------------------------|
| paymentId*  | integer | Unique identifier of the payment                                 |
| expand[]    | string  | Use to expand the `emi` details when the payment method is emi.  |

**Response:** <br>

```json
{
  "id": "pay_DG4ZdRK8ZnXC3k",
  "entity": "payment",
  "amount": 200000,
  "currency": "INR",
  "status": "authorized",
  "order_id": null,
  "invoice_id": null,
  "international": false,
  "method": "emi",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": false,
  "description": null,
  "card_id": "card_DG4ZdUO3xABb20",
  "bank": "ICIC",
  "wallet": null,
  "vpa": null,
  "email": "gaurav@example.com",
  "contact": "+919972000005",
  "notes": [],
  "fee": null,
  "tax": null,
  "error_code": null,
  "error_description": null,
  "error_source": null,
  "error_step": null,
  "error_reason": null,
  "emi": {
    "issuer": "ICIC",
    "rate": 1300,
    "duration": 6
  },
  "acquirer_data": {
    "auth_code": "828553"
  },
  "created_at": 1568026077
}
```
-------------------------------------------------------------------------------------------------------

### Fetch a Payment (With Expanded Card Details)

```rb
Razorpay::Payment.expand_details("pay_XXXXXXXXXXXXXX", {"expand[]": "card"})
```

**Parameters:**

| Name        | Type    | Description                                                         |
|-------------|---------|---------------------------------------------------------------------|
| paymentId*  | integer | Unique identifier of the payment                                    |
| expand[]    | string  | Use to expand the card details when the payment method is `card`.   |

**Response:** <br>

```json
{
  "id": "pay_H9oR0gLCaVlV6m",
  "entity": "payment",
  "amount": 100,
  "currency": "INR",
  "status": "failed",
  "order_id": "order_H9o58N6qmLYQKC",
  "invoice_id": null,
  "terminal_id": "term_G5kJnYM9GhhLYT",
  "international": false,
  "method": "card",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": false,
  "description": null,
  "card_id": "card_H9oR0ocen1cmZq",
  "card": {
    "id": "card_H9oR0ocen1cmZq",
    "entity": "card",
    "name": "Gaurav",
    "last4": "1213",
    "network": "RuPay",
    "type": "credit",
    "issuer": "UTIB",
    "international": false,
    "emi": false,
    "sub_type": "business"
  },
  "bank": null,
  "wallet": null,
  "vpa": null,
  "email": "gaurav.kumar@example.com",
  "contact": "+919000090000",
  "notes": {
    "email": "gaurav.kumar@example.com",
    "phone": "09000090000"
  },
  "fee": null,
  "tax": null,
  "error_code": "BAD_REQUEST_ERROR",
  "error_description": "Card issuer is invalid",
  "error_source": "customer",
  "error_step": "payment_authentication",
  "error_reason": "incorrect_card_details",
  "acquirer_data": {
    "auth_code": null,
    "authentication_reference_number": "100222021120200000000742753928"
  },
  "created_at": 1620807547
}
```

-------------------------------------------------------------------------------------------------------

### Fetch a Payment (With Expanded Offers Details)

```rb
Razorpay::Payment.expand_details("pay_XXXXXXXXXXXXXX", {"expand[]": "offers"})
```

**Parameters:**

| Name        | Type    | Description                                                    |
|-------------|---------|----------------------------------------------------------------|
| paymentId*  | integer | Unique identifier of the payment                               |
| expand[]    | string  | Use to expand the offers applied to a payment.                 |

**Response:** <br>

```json
{
  "id": "pay_G8VaL2Z68LRtDs",
  "entity": "payment",
  "amount": 900,
  "currency": "INR",
  "status": "captured",
  "order_id": "order_G8VXfKDWDEOHHd",
  "invoice_id": null,
  "international": false,
  "method": "netbanking",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": true,
  "offers": {
    "entity": "collection",
    "count": 1,
    "items": [
      {
        "id": "offer_G8VXOp0qNuEXzh"
      }
    ]
  },
  "description": "Purchase Shoes",
  "card_id": null,
  "bank": "KKBK",
  "wallet": null,
  "vpa": null,
  "email": "gaurav.kumar@example.com",
  "contact": "+919000090000",
  "customer_id": "cust_DitrYCFtCIokBO",
  "notes": [],
  "fee": 22,
  "tax": 4,
  "error_code": null,
  "error_description": null,
  "error_source": null,
  "error_step": null,
  "error_reason": null,
  "acquirer_data": {
    "bank_transaction_id": "0125836177",
    "authentication_reference_number": "100222021120200000000742753928"
  },
  "created_at": 1606985740
}
```

-------------------------------------------------------------------------------------------------------

### Fetch a Payment (With Expanded UPI Details)

```rb
Razorpay::Payment.expand_details("pay_XXXXXXXXXXXXXX", {"expand[]": "upi"})
```

**Parameters:**

| Name        | Type    | Description                                                   |
|-------------|---------|---------------------------------------------------------------|
| paymentId*  | integer | Unique identifier of the payment                              |
| expand[]    | string  | Use to expand the UPI details when the payment method is upi. |

**Response:** <br>

```json
{
  "id": "pay_DG4ZdRK8ZnXC3k",
  "entity": "payment",
  "amount": 100,
  "currency": "INR",
  "status": "captured",
  "order_id": "order_GjCr5oKh4AVC51",
  "invoice_id": null,
  "international": false,
  "method": "upi",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": true,
  "description": "Payment for Adidas shoes",
  "card_id": null,
  "bank": null,
  "wallet": null,
  "vpa": "gaurav.kumar@upi",
  "email": "gaurav.kumar@example.com",
  "contact": "9000090000",
  "customer_id": "cust_K6fNE0WJZWGqtN",
  "token_id": "token_KOdY$DBYQOv08n",
  "notes": [],
  "fee": 1,
  "tax": 0,
  "error_code": null,
  "error_description": null,
  "error_source": null,
  "error_step": null,
  "error_reason": null,
  "acquirer_data": {
    "rrn": "303107535132"
  },
  "created_at": 1605871409,
  "upi": {
    "payer_account_type": "credit_card",
    "vpa": "gaurav.kumar@upi",
    "flow": "in_app" // appears only for Turbo UPI Payments.
  }
}
```

-------------------------------------------------------------------------------------------------------

**PN: * indicates mandatory fields**
<br>
<br>
**For reference click [here](https://razorpay.com/docs/api/payments/)**