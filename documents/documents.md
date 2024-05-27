## Document

### Create a Document

```rb
Razorpay::Document.create({
  "file": File.new("/Users/your_name/Downloads/sample_uploaded.jpeg"),
  "purpose": "dispute_evidence"
});
```

**Parameters:**

| Name    | Type      | Description                                                     |
|---------|-----------|-----------------------------------------------------------------|
| file*   | string    | The URL generated once the business proof document is uploaded. |
| purpose | string    | Possible value is `dispute_evidence`                            |

**Response:**
```json
{
  "id": "doc_EsyWjHrfzb59Re",
  "entity": "document",
  "purpose": "dispute_evidence",
  "name": "doc_19_12_2020.jpg",
  "mime_type": "image/png",
  "size": 2863,
  "created_at": 1590604200
}
```
-------------------------------------------------------------------------------------------------------

### Fetch Document Information

```rb
documentId = "doc_NiyXWXXXXXXXXX"

Razorpay::Document.fetch(documentId)
```

**Parameters:**

| Name        | Type      | Description                                      |
|-------------|-----------|--------------------------------------------------|
| documentId  | string    | The unique identifier of the document.           |

**Response:**
```json
{
  "entity": "document",
  "id": "doc_00000000000000",
  "purpose": "dispute_evidence",
  "created_at": 1701701378,
  "mime_type": "application/pdf",
  "display_name": "ppm_00000000000000",
  "size": 404678,
  "url": ""
}
```
-------------------------------------------------------------------------------------------------------

**PN: * indicates mandatory fields**
<br>
<br>
**For reference click [here](https://razorpay.com/docs/api/documents)**