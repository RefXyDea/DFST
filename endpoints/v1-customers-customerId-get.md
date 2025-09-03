# GET /xcloud/v1/customers/{customerId}

## Overview
Retrieves detailed information for a specific customer by their unique customer ID.

## Endpoint Details
- **Path**: `/xcloud/v1/customers/{customerId}`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required

## Path Parameters
- **customerId** (string, required): The unique identifier of the customer to retrieve

## Response
### Success Response (200 OK)
```json
{
  "customerId": "FST-1536312680993-FromPostman2",
  "customerName": "Dewatering Solutions Inc",
  "description": "Municipal water management services",
  "status": "ACTIVE",
  "createdAt": "2024-01-01T10:30:00Z",
  "updatedAt": "2024-01-02T15:30:00Z",
  "contactInfo": {
    "email": "contact@dewatering-solutions.com",
    "phone": "+1-555-0123",
    "address": {
      "street": "123 Industrial Drive",
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
  "statistics": {
    "deviceCount": 25,
    "activeDevices": 23,
    "totalUsers": 12,
    "lastActivity": "2024-01-02T15:30:00Z",
    "dataPointsToday": 2847
  },
  "settings": {
    "dataRetentionDays": 365,
    "alertFrequency": "immediate",
    "reportingEnabled": true
  }
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
- **vig_orbcomm**: Retrieves customer details for device operations
- **vig_package**: Customer management utilities

### Test Services
- **fst_location (test)**: Customer detail verification with test customer IDs

### Python Library Usage (vig_orbcomm/vig_package)
```python
"get_customer": {
    "path": "/xcloud/v1/customers/{customerId}",
    "verb": "GET",
    "md5": False
}
```

### Test Examples (fst_location)
From test code, example customer IDs:
- `FST-1536312680993-FromPostman2`
- `FST-1536316721808-NewCustByAks234`

## Use Cases
- **Device Management**: Get customer details during device registration
- **User Interface**: Display customer information in dashboards
- **Billing**: Retrieve customer data for billing operations
- **Support**: Access customer details for troubleshooting

## Related Endpoints
- [GET /xcloud/v1/customers](v1-customers-get.md) - List all customers
- [POST /xcloud/v1/customers](v1-customers-post.md) - Register new customer
- [PUT /xcloud/v1/customers/{customerId}](v1-customers-customerId-put.md) - Update customer
- [HEAD /xcloud/v1/customers/{customerIds}](v1-customers-customerIds-head.md) - Check customer existence