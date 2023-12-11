## Generic Access point


```rb
Razorpay.setup('key_id', 'key_secret')
```

### Method Signature
```rb
Razorpay::Generic.new(entity).do(url, method, payload, version)
```    

**Parameters:**

| Name          | Type        | Description                                 |
|---------------|-------------|---------------------------------------------|
| entity*       | string      | The endpoint to which the request will be made. (e.g., "contacts" or "accounts") |
| url*          | string      | Add params or query or query (e.g., "/order_000000000000001" or "?count=1") |
| method*       | string      | The HTTP method for the request (e.g., 'Get', 'Post', 'Put', 'Patch', 'Delete'). |
| payload          | object      | The data to be sent with the request.|
| version         | string    | Add version (e.g., "v1" or "v2") |

-------------------------------------------------------------------------------------------------------

### Create a contacts using POST

```rb

payload = {
  "name": "Gaurav Kumar",
  "email": "gaurav.kumar@example.com",
  "contact": "9123456789",
  "type": "employee",
  "reference_id":"Acme Contact ID 12345",
  "notes": {
    "notes_key_1":"Tea, Earl Grey, Hot",
    "notes_key_2":"Tea, Earl Grey… decaf.",
  },
}

Razorpay::Generic.new("contacts").do("/", "Post", payload)
```

**Response:**

```json
{
  "id": "cont_00000000000001",
  "entity": "contact",
  "name": "Gaurav Kumar",
  "contact": "9123456789",
  "email": "gaurav.kumar@example.com",
  "type": "employee",
  "reference_id": "Acme Contact ID 12345",
  "batch_id": null,
  "active": true,
  "notes": {
    "notes_key_1": "Tea, Earl Grey, Hot",
    "notes_key_2": "Tea, Earl Grey… decaf."
  },
  "created_at": 1545320320
}
```

-------------------------------------------------------------------------------------------------------

### Fetch an order using GET

```rb
Razorpay::Generic.new("orders").do("/order_00000000000001", "Get", {})
```

**Response:**

```json
{
  "amount": 307,
  "amount_due": 0,
  "amount_paid": 307,
  "attempts": 1,
  "created_at": 1695625101,
  "currency": "INR",
  "entity": "order",
  "id": "order_00000000000001",
  "notes": [],
  "offer_id": null,
  "receipt": "851617",
  "status": "paid"
}
```

-------------------------------------------------------------------------------------------------------

### Fetch payments of a linked account using headers

```rb
Razorpay.headers = {"X-Razorpay-Account" => "acc_00000000000001"}

Razorpay::Generic.new("payments").do("/pay_00000000000001", "Get", {})
```

**Response:**

```json
{
  "entity": "collection",
  "count": 2,
  "items": [
    {
      "id": "pay_00000000000001",
      "entity": "payment",
      "amount": 10000,
      "currency": "INR",
      "status": "captured",
      "order_id": "order_00000000000001",
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
      "contact": "9999999999",
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

**PN: * indicates mandatory fields**
<br>
<br>
