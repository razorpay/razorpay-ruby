## Transfers

```rb
require "razorpay"
Razorpay.setup('key_id', 'key_secret')
```

### Create transfers from payment

```rb

paymentId = "pay_E8JR8E0XyjUSZd"

para_attr = {
   "transfers": [
    {
      "account": 'acc_HgzcrXeSLfNP9U',
      "amount": 100,
      "currency": "INR",
      "notes": {
        "name": "Gaurav Kumar",
        "roll_no": "IEC2011025"
      },
      "linked_account_notes": [
        "branch"
      ],
      "on_hold": 1,
      "on_hold_until": 1671222870
    }
  ]
 }

Razorpay::Payment.fetch(paymentId).transfer(para_attr)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| paymentId*   | string      | The id of the payment to be fetched  |
| transfers   | object     | All parameters listed [here](https://razorpay.com/docs/api/route/#create-transfers-from-payments) are supported |

**Response:**
```json
{
  "id": "pay_DJiaO3iqUZaZrO",
  "entity": "payment",
  "amount": 5000,
  "currency": "INR",
  "status": "captured",
  "order_id": null,
  "invoice_id": null,
  "international": false,
  "method": "netbanking",
  "amount_refunded": 0,
  "refund_status": null,
  "captured": true,
  "description": "Credits towards consultation",
  "card_id": null,
  "bank": "UTIB",
  "wallet": null,
  "vpa": null,
  "email": "void@razorpay.com",
  "contact": "+919191919191",
  "notes": [],
  "fee": 171,
  "tax": 26,
  "error_code": null,
  "error_description": null,
  "error_source": null,
  "error_step": null,
  "error_reason": null,
  "acquirer_data": {
    "bank_transaction_id": "7909502"
  },
  "created_at": 1568822005
}
```
-------------------------------------------------------------------------------------------------------

### Create transfers from order

```rb
para_attr = {
  "amount": 2000,
  "currency": "INR",
  "transfers": [
    {
      "account": "acc_CPRsN1LkFccllA",
      "amount": 1000,
      "currency": "INR",
      "notes": {
        "branch": "Acme Corp Bangalore North",
        "name": "Gaurav Kumar"
      },
      "linked_account_notes": [
        "branch"
      ],
      "on_hold": 1,
      "on_hold_until": 1671222870
    },
    {
      "account": "acc_CNo3jSI8OkFJJJ",
      "amount": 1000,
      "currency": "INR",
      "notes": {
        "branch": "Acme Corp Bangalore South",
        "name": "Saurav Kumar"
      },
      "linked_account_notes": [
        "branch"
      ],
      "on_hold": 0
    }
  ]
}

Razorpay::Order.create(para_attr)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| amount*   | integer      | The transaction amount, in paise |
| currency*   | string  | The currency of the payment (defaults to INR)  |
|  receipt      | string      | A unique identifier provided by you for your internal reference. |
| transfers   | array     | All parameters listed [here](https://razorpay.com/docs/api/route/#create-transfers-from-orders) are supported |

**Response:**
```json
{
    "id": "order_Jhf1Sn06my7AUb",
    "entity": "order",
    "amount": 2000,
    "amount_paid": 0,
    "amount_due": 2000,
    "currency": "INR",
    "receipt": null,
    "offer_id": "offer_JGQvQtvJmVDRIA",
    "offers": [
        "offer_JGQvQtvJmVDRIA"
    ],
    "status": "created",
    "attempts": 0,
    "notes": [],
    "created_at": 1655272138,
    "transfers": [
        {
            "id": "trf_Jhf1SpAYVIeRoP",
            "entity": "transfer",
            "status": "created",
            "source": "order_Jhf1Sn06my7AUb",
            "recipient": "acc_HjVXbtpSCIxENR",
            "amount": 1000,
            "currency": "INR",
            "amount_reversed": 0,
            "notes": {
                "branch": "Acme Corp Bangalore North",
                "name": "Gaurav Kumar"
            },
            "linked_account_notes": [
                "branch"
            ],
            "on_hold": true,
            "on_hold_until": 1671222870,
            "recipient_settlement_id": null,
            "created_at": 1655272138,
            "processed_at": null,
            "error": {
                "code": null,
                "description": null,
                "reason": null,
                "field": null,
                "step": null,
                "id": "trf_Jhf1SpAYVIeRoP",
                "source": null,
                "metadata": null
            }
        }
    ]
}
```
-------------------------------------------------------------------------------------------------------

### Direct transfers

```rb
para_attr = {
  "account": accountId,
  "amount": 500,
  "currency": "INR"
}

Razorpay::Transfer.create(para_attr)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| accountId*   | string      | The id of the account to be fetched  |
| amount*   | integer      | The amount to be captured (should be equal to the authorized amount, in paise) |
| currency*   | string  | The currency of the payment (defaults to INR)  |
| notes | object | | A key-value pair   |

**Response:**
```json
{
   "id":"trf_E9utgtfGTcpcmm",
   "entity":"transfer",
   "transfer_status":"pending",
   "settlement_status":null,
   "source":"acc_CJoeHMNpi0nC7k",
   "recipient":"acc_CPRsN1LkFccllA",
   "amount":100,
   "currency":"INR",
   "amount_reversed":0,
   "notes":[
      
   ],
   "fees":1,
   "tax":0,
   "on_hold":false,
   "on_hold_until":null,
   "recipient_settlement_id":null,
   "created_at":1580219046,
   "linked_account_notes":[
      
   ],
   "processed_at":null,
   "error":{
      "code":null,
      "description":null,
      "field":null,
      "source":null,
      "step":null,
      "reason":null
   }
}
```
-------------------------------------------------------------------------------------------------------

### Fetch transfer for a payment

```rb
paymentId = "pay_E8JR8E0XyjUSZd"

Razorpay::Payment.fetch(paymentId).fetch_transfer
```

**Parameters:**

| Name          | Type        | Description                                |
|---------------|-------------|---------------------------------------------|
| paymentId*   | string      | The id of the payment to be fetched  |

**Response:**
```json
{
  "entity": "collection",
  "count": 1,
  "items": [
    {
      "id": "trf_EAznuJ9cDLnF7Y",
      "entity": "transfer",
      "source": "pay_E9up5WhIfMYnKW",
      "recipient": "acc_CMaomTz4o0FOFz",
      "amount": 1000,
      "currency": "INR",
      "amount_reversed": 100,
      "notes": [],
      "fees": 3,
      "tax": 0,
      "on_hold": false,
      "on_hold_until": null,
      "recipient_settlement_id": null,
      "created_at": 1580454666,
      "linked_account_notes": [],
      "processed_at": 1580454666
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### Fetch transfer for an order

```rb
orderId = "order_DSkl2lBNvueOly"

Razorpay::Order.fetch_transfer_order(orderId)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| orderId*   | string      | The id of the order to be fetched  |

**Response:**
```json
{
  "id": "order_I7waiV9PUGADuv",
  "entity": "order",
  "amount": 50000,
  "amount_paid": 50000,
  "amount_due": 0,
  "currency": "INR",
  "receipt": "55",
  "offer_id": null,
  "status": "paid",
  "attempts": 1,
  "notes": {
    "woocommerce_order_number": "55"
  },
  "created_at": 1633936677,
  "transfers": {
    "entity": "collection",
    "count": 1,
    "items": [
      {
        "id": "trf_I7waiajxgS5jWL",
        "entity": "transfer",
        "status": "processed",
        "source": "order_I7waiV9PUGADuv",
        "recipient": "acc_HalyQGZh9ZyiGg",
        "amount": 10000,
        "currency": "INR",
        "amount_reversed": 0,
        "fees": 12,
        "tax": 2,
        "notes": [],
        "linked_account_notes": [],
        "on_hold": false,
        "on_hold_until": null,
        "settlement_status": "pending",
        "recipient_settlement_id": null,
        "created_at": 1633936677,
        "processed_at": 1633936700,
        "error": {
          "code": null,
          "description": null,
          "reason": null,
          "field": null,
          "step": null,
          "id": "trf_I7waiajxgS5jWL",
          "source": null,
          "metadata": null
        }
      }
    ]
  }
}

```
-------------------------------------------------------------------------------------------------------

### Fetch transfer

```rb
transferId = "trf_E7V62rAxJ3zYMo"

Razorpay::Transfer.fetch(transferId)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| transferId*   | string      | The id of the transfer to be fetched  |

**Response:**
```json
{
  "id": "trf_JJD536GI6wuz3m",
  "entity": "transfer",
  "status": "processed",
  "source": "pay_JGmCgTEa9OTQcX",
  "recipient": "acc_IRQWUleX4BqvYn",
  "amount": 300,
  "currency": "INR",
  "amount_reversed": 0,
  "fees": 1,
  "tax": 0,
  "notes": {
    "name": "Saurav Kumar",
    "roll_no": "IEC2011026"
  },
  "linked_account_notes": [
    "roll_no"
  ],
  "on_hold": false,
  "on_hold_until": null,
  "settlement_status": "pending",
  "recipient_settlement_id": null,
  "created_at": 1649933574,
  "processed_at": 1649933579,
  "error": {
    "code": null,
    "description": null,
    "reason": null,
    "field": null,
    "step": null,
    "id": "trf_JJD536GI6wuz3m",
    "source": null,
    "metadata": null
  }
}
```
-------------------------------------------------------------------------------------------------------

### Fetch transfers for a settlement

```rb
recipientSettlementId = "setl_DHYJ3dRPqQkAgV"

Razorpay::Transfer.all({
   "recipient_settlement_id": recipientSettlementId
})
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| recipientSettlementId*   | string    | The recipient settlement id obtained from the settlement.processed webhook payload.  |

**Response:**
```json
{
  "entity": "collection",
  "count": 1,
  "items": [
    {
      "id": "trf_HWjmkReRGPhguR",
      "entity": "transfer",
      "status": "processed",
      "source": "pay_HWjY9DZSMsbm5E",
      "recipient": "acc_HWjl1kqobJzf4i",
      "amount": 1000,
      "currency": "INR",
      "amount_reversed": 0,
      "fees": 3,
      "tax": 0,
      "notes": [],
      "linked_account_notes": [],
      "on_hold": false,
      "on_hold_until": null,
      "settlement_status": "settled",
      "recipient_settlement_id": "setl_HYIIk3H0J4PYdX",
      "created_at": 1625812996,
      "processed_at": 1625812996,
      "error": {
        "code": null,
        "description": null,
        "reason": null,
        "field": null,
        "step": null,
        "id": "trf_HWjmkReRGPhguR",
        "source": null,
        "metadata": null
      }
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### Fetch settlement details

```rb
Razorpay::Transfer.fetch_settlements
```

**Response:**
```json
{
  "entity": "collection",
  "count": 1,
  "items": [
    {
      "id": "trf_JnRRvcSbZb1VHN",
      "entity": "transfer",
      "status": "processed",
      "source": "acc_HZbJUcl6DBDLIN",
      "recipient": "acc_HjVXbtpSCIxENR",
      "amount": 500,
      "currency": "INR",
      "amount_reversed": 0,
      "fees": 1,
      "tax": 0,
      "notes": [],
      "linked_account_notes": [],
      "on_hold": false,
      "on_hold_until": null,
      "settlement_status": null,
      "recipient_settlement_id": null,
      "recipient_settlement": null,
      "created_at": 1656534379,
      "processed_at": 1656534379,
      "error": {
        "code": null,
        "description": null,
        "reason": null,
        "field": null,
        "step": null,
        "id": "trf_JnRRvcSbZb1VHN",
        "source": null,
        "metadata": null
      }
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### Refund payments and reverse transfer from a linked account

```rb
paymentId = "pay_EAdwQDe4JrhOFX"

para_attr = {
    "amount": 100,
    "reverse_all": 1
}

Razorpay::Payment.fetch(paymentId).refund(para_attr)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| paymentId*   | string      | The id of the payment to be fetched  |
| amount*   | integer      | The amount to be captured (should be equal to the authorized amount, in paise) |
| reverse_all   | boolean    | Reverses transfer made to a linked account. Possible values:<br> * `1` - Reverses transfer made to a linked account.<br>* `0` - Does not reverse transfer made to a linked account.|

**Response:**
```json
{
  "id": "rfnd_JJFNlNXPHY640A",
  "entity": "refund",
  "amount": 100,
  "currency": "INR",
  "payment_id": "pay_JJCqynf4fQS0N1",
  "notes": [],
  "receipt": null,
  "acquirer_data": {
    "arn": null
  },
  "created_at": 1649941680,
  "batch_id": null,
  "status": "processed",
  "speed_processed": "normal",
  "speed_requested": "normal"
}
```
-------------------------------------------------------------------------------------------------------

### Fetch payments of a linked account

```rb
Razorpay.headers = {"X-Razorpay-Account" => "linkedAccountId"}

Razorpay::Payment.all
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| X-Razorpay-Account   | string      | The linked account id to fetch the payments received by linked account |

**Response:**
```json
{
  "entity": "collection",
  "count": 1,
  "items": [
    {
      "id": "pay_JJCqynf4fQS0N1",
      "entity": "payment",
      "amount": 10000,
      "currency": "INR",
      "status": "captured",
      "order_id": "order_JJCqnZG8f3754z",
      "invoice_id": null,
      "international": false,
      "method": "netbanking",
      "amount_refunded": 0,
      "refund_status": null,
      "captured": true,
      "description": "#JJCqaOhFihfkVE",
      "card_id": null,
      "bank": "YESB",
      "wallet": null,
      "vpa": null,
      "email": "john.example@example.com",
      "contact": "+919820958250",
      "notes": [],
      "fee": 236,
      "tax": 36,
      "error_code": null,
      "error_description": null,
      "error_source": null,
      "error_step": null,
      "error_reason": null,
      "acquirer_data": {
        "bank_transaction_id": "2118867"
      },
      "created_at": 1649932775
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### Reverse transfers from all linked accounts

```rb
transferId = "trf_EAznuJ9cDLnF7Y"

para_attr = {
    "amount":100
}

Razorpay::Transfer.fetch(transferId).reverse(para_attr)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| transferId*   | string      | The id of the transfer to be fetched  |
| amount   | integer      | The amount to be captured (should be equal to the authorized amount, in paise) |

**Response:**
```json
{
  "id": "rvrsl_EB0BWgGDAu7tOz",
  "entity": "reversal",
  "transfer_id": "trf_EAznuJ9cDLnF7Y",
  "amount": 100,
  "fee": 0,
  "tax": 0,
  "currency": "INR",
  "notes": [],
  "initiator_id": "CJoeHMNpi0nC7k",
  "customer_refund_id": null,
  "created_at": 1580456007
}
```
-------------------------------------------------------------------------------------------------------

### Hold settlements for transfers
```rb

paymentId = "pay_EB1R2s8D4vOAKG" 

para_attr = {
  "transfers": [
    {
      "amount": 100,
      "account": "acc_I0QRP7PpvaHhpB",
      "currency": "INR",
      "on_hold": 1
    }
  ]
}

Razorpay::Payment.fetch(paymentId).transfer(para_attr)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| paymentId*   | string      | The id of the transfer to be fetched  |
| transfers   | array     | All parameters listed here https://razorpay.com/docs/api/route/#hold-settlements-for-transfers are supported |

**Response:**
```json
{
  "entity": "collection",
  "count": 1,
  "items": [
    {
      "id": "trf_Jfm1KCF6w1oWgy",
      "entity": "transfer",
      "status": "pending",
      "source": "pay_JXPULbHbkkkS8D",
      "recipient": "acc_I0QRP7PpvaHhpB",
      "amount": 100,
      "currency": "INR",
      "amount_reversed": 0,
      "notes": [],
      "linked_account_notes": [],
      "on_hold": true,
      "on_hold_until": null,
      "recipient_settlement_id": null,
      "created_at": 1654860101,
      "processed_at": null,
      "error": {
        "code": null,
        "description": null,
        "reason": null,
        "field": null,
        "step": null,
        "id": "trf_Jfm1KCF6w1oWgy",
        "source": null,
        "metadata": null
      }
    }
  ]
}
```
-------------------------------------------------------------------------------------------------------

### Modify settlement hold for transfers
```rb
transferId = "trf_JhemwjNekar9Za"

para_attr = {
  "on_hold": "1",
  "on_hold_until": "1679691505"
}
Razorpay::Transfer.fetch(transferId).edit(para_attr)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| transferId*   | string      | The id of the transfer to be fetched  |
| on_hold*   | boolean      | Possible values is `0` or `1`  |
| on_hold_until   | integer      | Timestamp, in Unix, that indicates until when the settlement of the transfer must be put on hold |

**Response:**
```json
{
    "entity": "collection",
    "count": 1,
    "items": [
        {
            "id": "trf_JhemwjNekar9Za",
            "entity": "transfer",
            "status": "pending",
            "source": "pay_I7watngocuEY4P",
            "recipient": "acc_HjVXbtpSCIxENR",
            "amount": 100,
            "currency": "INR",
            "amount_reversed": 0,
            "notes": [],
            "linked_account_notes": [],
            "on_hold": true,
            "on_hold_until": null,
            "recipient_settlement_id": null,
            "created_at": 1655271313,
            "processed_at": null,
            "error": {
                "code": null,
                "description": null,
                "reason": null,
                "field": null,
                "step": null,
                "id": "trf_JhemwjNekar9Za",
                "source": null,
                "metadata": null
            }
        }
    ]
}
```

-------------------------------------------------------------------------------------------------------

### Fetch Reversals for a Transfer
```rb
transferId = "trf_JhemwjNekar9Za"
Razorpay::Transfer.reversals(transferId)
```

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| transferId*   | string      | The id of the transfer to be fetched        |

**Response:**
```json
{
   "entity":"collection",
   "count":1,
   "items":[
      {
         "id":"rvrsl_Lt09xvyzskI7KZ",
         "entity":"reversal",
         "transfer_id":"trf_Lt048W7cgLdo1u",
         "amount":50000,
         "fee":0,
         "tax":0,
         "currency":"INR",
         "notes":[
            
         ],
         "initiator_id":"Ghri4beeOuMTAb",
         "customer_refund_id":null,
         "utr":null,
         "created_at":1684822489
      }
   ]
}
```

-------------------------------------------------------------------------------------------------------

**PN: * indicates mandatory fields**
<br>
<br>
**For reference click [here](https://razorpay.com/docs/api/route/#transfers/)**