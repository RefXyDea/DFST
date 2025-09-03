# POST /xcloud/v1/customers

## Overview
Registers a new customer in XCloud. Creates a customer record with contact information, location details, and configuration settings for device and data management.

## Endpoint Details
- **Path**: `/xcloud/v1/customers`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256, md5=True)

## Request Body
```json
{
  "customerId": "FST-1536316721808-NewCustomer",
  "customerName": "Dewatering Solutions Inc",
  "description": "Municipal water management services",
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
  "settings": {
    "dataRetentionDays": 365,
    "alertFrequency": "immediate",
    "reportingEnabled": true
  },
  "status": "ACTIVE"
}
```

## Response
### Success Response (201 Created)
```json
{
  "customerId": "FST-1536316721808-NewCustomer",
  "customerName": "Dewatering Solutions Inc",
  "status": "ACTIVE",
  "createdAt": "2024-01-01T10:30:00Z",
  "apiKeys": {
    "primary": "api-key-12345",
    "secondary": "api-key-67890"
  },
  "limits": {
    "maxDevices": 100,
    "maxUsers": 50,
    "maxDataPoints": 1000000
  }
}
```

### Conflict Response (409 Conflict)
```json
{
  "error": "CUSTOMER_EXISTS",
  "message": "Customer with ID 'FST-1536316721808-NewCustomer' already exists",
  "customerId": "FST-1536316721808-NewCustomer"
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Registers new customers during satellite service setup
- **vig_package**: Customer management utilities
- **sitesfromexstcust**: Customer data migration and setup

### Test Services
- **fst_location (test)**: Customer registration testing with test data

### Python Library Usage (vig_orbcomm/vig_package)
From `vig_orbcomm/vig_library/xcloud.py` and `vig_package/xcloud.py`:
```python
"register_customer": {
    "path": "/xcloud/v1/customers",
    "verb": "POST",
    "md5": True
}
```

### Customer Migration Tool (sitesfromexstcust)
From `sitesfromexstcust/ProjectModules/customer_functions.py`:
```python
path = "/xcloud/v1/customers"
header = xcloud_header(api_secret, service_id, path=path, method="GET")
```

### Test Examples (fst_location)
From test files, customer IDs follow patterns like:
- `FST-1536312680993-FromPostman2`
- `FST-1536316721808-NewCustByAks234`
- `FST-{timestamp}-{identifier}`

## Customer ID Format
- **Prefix**: "FST-" (Field Smart Technology)
- **Timestamp**: Unix timestamp or formatted date
- **Identifier**: Unique string identifier
- **Example**: `FST-1536316721808-NewCustomer`

## Required Fields
- **customerId**: Unique identifier (following FST- pattern)
- **customerName**: Display name for the customer
- **contactInfo.email**: Primary contact email
- **status**: ACTIVE, INACTIVE, or SUSPENDED

## Optional Fields
- **description**: Customer description or notes
- **contactInfo**: Additional contact details
- **businessInfo**: Industry and sector information
- **settings**: Configuration preferences
- **location**: Geographic information

## Validation Rules
- **customerId**: Must be unique, follow FST- pattern
- **email**: Must be valid email format
- **phone**: Valid phone number format
- **timezone**: Valid IANA timezone identifier

## Related Endpoints
- [GET /xcloud/v1/customers](v1-customers-get.md) - List all customers
- [GET /xcloud/v1/customers/{customerId}](v1-customers-customerId-get.md) - Get specific customer
- [PUT /xcloud/v1/customers/{customerId}](v1-customers-customerId-put.md) - Update customer
- [HEAD /xcloud/v1/customers/{customerIds}](v1-customers-customerIds-head.md) - Check customer existence