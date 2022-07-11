## items

```rb
require "razorpay"
Razorpay.setup('key_id', 'key_secret')
```

### Create item

```rb
Razorpay::Item.create({
  "name": "Book / English August",
  "description": "An indian story, Booker prize winner.",
  "amount": 20000,
  "currency": "INR"
});
```

**Parameters:**

| Name            | Type    | Description                                                                  |
|-----------------|---------|------------------------------------------------------------------------------|
| name*          | string | Name of the item.                    |
| description        | string  | A brief description of the item.  |
| amount         | integer  | Amount of the order to be paid     |
| currency*           | string  | Currency of the order. Currently only `INR` is supported.    |

**Response:**
```json
{
  "id": "item_Jf5MlwKlPMOKBV",
  "active": true,
  "name": "Book / English August",
  "description": "An indian story, Booker prize winner.",
  "amount": 20000,
  "unit_amount": 20000,
  "currency": "INR",
  "type": "invoice",
  "unit": null,
  "tax_inclusive": false,
  "hsn_code": null,
  "sac_code": null,
  "tax_rate": null,
  "tax_id": null,
  "tax_group_id": null,
  "created_at": 1654709890
}
```

-------------------------------------------------------------------------------------------------------

### Fetch all items

```rb
options = {"count":1}

Razorpay::Item.all(options)
```
**Parameters:**

| Name  | Type      | Description                                      |
|-------|-----------|--------------------------------------------------|
| from  | timestamp | timestamp after which the item were created  |
| to    | timestamp | timestamp before which the item were created |
| count | integer   | number of item to fetch (default: 10)        |
| skip  | integer   | number of item to be skipped (default: 0)    |
| name        | string | Name of the item.                    |
| description        | string  | A brief description of the item.  |
| amount         | integer  | Amount of the order to be paid     |
| currency           | string  | Currency of the order. Currently only `INR` is supported.    |
| active   | boolean  | Possible values is `0` or `1` |

**Response:**
```json
{
    "entity": "collection",
    "count": 1,
    "items": [
        {
            "id": "item_JnjKnSWxjILdWu",
            "active": true,
            "name": "Book / English August",
            "description": "An indian story, Booker prize winner.",
            "amount": 20000,
            "unit_amount": 20000,
            "currency": "INR",
            "type": "invoice",
            "unit": null,
            "tax_inclusive": false,
            "hsn_code": null,
            "sac_code": null,
            "tax_rate": null,
            "tax_id": null,
            "tax_group_id": null,
            "created_at": 1656597363
        }
    ]
}
```
-------------------------------------------------------------------------------------------------------
### Fetch particular item

```rb
itemId = "item_7Oxp4hmm6T4SCn"

Razorpay::Item.fetch(itemId)
```
**Parameters**

| Name     | Type   | Description                         |
|----------|--------|-------------------------------------|
| itemId* | string | The id of the item to be fetched |

**Response:**
```json
{
    "id": "item_JnjKnSWxjILdWu",
    "active": true,
    "name": "Book / English August",
    "description": "An indian story, Booker prize winner.",
    "amount": 20000,
    "unit_amount": 20000,
    "currency": "INR",
    "type": "invoice",
    "unit": null,
    "tax_inclusive": false,
    "hsn_code": null,
    "sac_code": null,
    "tax_rate": null,
    "tax_id": null,
    "tax_group_id": null,
    "created_at": 1656597363
}
```

-------------------------------------------------------------------------------------------------------

### Update item

```rb
itemId = "item_JDcbIdX9xojCje"

para_attr = {
  "name": "Book / Ignited Minds - Updated name!",
  "description": "New descirption too. :).",
  "amount": 20000,
  "currency": "INR",
  "active": true
}

Razorpay::Item.edit(itemId,para_attr)
```
**Parameters**

| Name     | Type   | Description                         |
|----------|--------|-------------------------------------|
| itemId* | string | The id of the item to be fetched |
| name       | string | Name of the item.                    |
| description  | string  | A brief description of the item.  |
| amount         | integer  | Amount of the order to be paid     |
| currency           | string  | Currency of the order. Currently only `INR` is supported.    |
| active   | boolean  | Possible values is `0` or `1` |

**Response:**
```json
{
  "id": "item_JInaSLODeDUQiQ",
  "active": true,
  "name": "Book / Ignited Minds - Updated name!",
  "description": "New descirption too.",
  "amount": 20000,
  "unit_amount": 20000,
  "currency": "INR",
  "type": "invoice",
  "unit": null,
  "tax_inclusive": false,
  "hsn_code": null,
  "sac_code": null,
  "tax_rate": null,
  "tax_id": null,
  "tax_group_id": null,
  "created_at": 1649843796
}
```
-------------------------------------------------------------------------------------------------------
### Delete item

```rb
itemId = "item_Jc7wDjjQ4x305A"

Razorpay::Item.delete(itemId)
```
**Parameters**

| Name     | Type   | Description                         |
|----------|--------|-------------------------------------|
| itemId* | string | The id of the item to be fetched |

**Response:**
```json
[]
```
-------------------------------------------------------------------------------------------------------

**PN: * indicates mandatory fields**
<br>
<br>
**For reference click [here](https://razorpay.com/docs/api/items)**