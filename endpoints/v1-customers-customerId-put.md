# PUT /xcloud/v1/customers/{customerId}

## Overview
Updates an existing customer's information in XCloud. Allows modification of customer details, contact information, settings, and status.

## Endpoint Details
- **Path**: `/xcloud/v1/customers/{customerId}`
- **Method**: PUT
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256, md5=True)

## Path Parameters
- **customerId** (string, required): The unique identifier of the customer to update

## Request Body
```json
{
  "customerName": "Updated Dewatering Solutions Inc",
  "description": "Updated municipal water management services",
  "contactInfo": {
    "email": "updated-contact@dewatering-solutions.com",
    "phone": "+1-555-9999",
    "address": {
      "street": "456 New Industrial Drive",
      "city": "Springfield", 
      "state": "IL",
      "country": "USA",
      "postalCode": "62701"
    }
  },
  "businessInfo": {
    "industry": "Water Management",
    "sector": "Municipal Services",
    "timezone": "America/Chicago"
  },
  "settings": {
    "dataRetentionDays": 730,
    "alertFrequency": "hourly",
    "reportingEnabled": true
  },
  "status": "ACTIVE"
}
```

## Response
### Success Response (200 OK)
```json
{
  "customerId": "FST-1536316721808-NewCustByAks234",
  "customerName": "Updated Dewatering Solutions Inc",
  "status": "ACTIVE",
  "updatedAt": "2024-01-02T16:30:00Z",
  "changes": [
    "customerName",
    "contactInfo.email",
    "contactInfo.phone",
    "settings.dataRetentionDays"
  ]
}
```

### Not Found Response (404 Not Found)
```json
{
  "error": "CUSTOMER_NOT_FOUND",
  "message": "Customer with ID 'FST-invalid-id' not found",
  "customerId": "FST-invalid-id"
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Updates customer information during service changes
- **vig_package**: Customer management utilities

### Test Services
- **fst_location (test)**: Customer update testing

### Python Library Usage (vig_orbcomm/vig_package)
```python
"update_customer": {
    "path": "/xcloud/v1/customers/{customerId}",
    "verb": "PUT",
    "md5": True
}
```

### Test Examples (fst_location)
From test code, example operations:
- Update customer `FST-1536316721808-NewCustByAks234`
- Modify contact information and settings
- Change customer status

## Updatable Fields
- **customerName**: Display name
- **description**: Customer description
- **contactInfo**: Contact details and address
- **businessInfo**: Industry and timezone information
- **settings**: Configuration preferences
- **status**: Customer status (ACTIVE, INACTIVE, SUSPENDED)

## Validation Rules
- **customerId**: Cannot be changed (path parameter only)
- **email**: Must be valid email format
- **phone**: Valid phone number format
- **status**: Must be valid enum value
- **dataRetentionDays**: Positive integer

## Related Endpoints
- [GET /xcloud/v1/customers/{customerId}](v1-customers-customerId-get.md) - Get customer details
- [POST /xcloud/v1/customers](v1-customers-post.md) - Register new customer
- [GET /xcloud/v1/customers](v1-customers-get.md) - List all customers
- [HEAD /xcloud/v1/customers/{customerIds}](v1-customers-customerIds-head.md) - Check customer existence