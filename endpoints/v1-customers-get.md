# GET /xcloud/v1/customers

## Overview
Retrieves a list of all customers accessible to the authenticated service. Returns customer information including IDs, names, status, and contact details.

## Endpoint Details
- **Path**: `/xcloud/v1/customers`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required

## Request Parameters
Optional query parameters:
- **status** (string): Filter by customer status (ACTIVE, INACTIVE, SUSPENDED)
- **limit** (integer): Maximum number of customers to return
- **offset** (integer): Number of customers to skip for pagination

## Response
### Success Response (200 OK)
```json
[
  {
    "customerId": "FST-1536312680993-Customer1",
    "customerName": "Dewatering Solutions Inc",
    "status": "ACTIVE",
    "createdAt": "2024-01-01T10:30:00Z",
    "contactInfo": {
      "email": "contact@dewatering-solutions.com",
      "phone": "+1-555-0123"
    },
    "deviceCount": 25,
    "lastActivity": "2024-01-02T15:30:00Z"
  },
  {
    "customerId": "FST-1536316721808-Customer2", 
    "customerName": "Municipal Water Services",
    "status": "ACTIVE",
    "createdAt": "2024-01-01T12:00:00Z",
    "contactInfo": {
      "email": "admin@municipal-water.gov",
      "phone": "+1-555-0456"
    },
    "deviceCount": 150,
    "lastActivity": "2024-01-02T16:45:00Z"
  }
]
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Lists customers for device registration and management
- **vig_package**: Customer management utilities
- **sitesfromexstcust**: Customer data migration and export

### Test Services
- **fst_location (test)**: Customer listing verification

### Python Library Usage (vig_orbcomm/vig_package)
```python
"get_customers": {
    "path": "/xcloud/v1/customers",
    "verb": "GET",
    "md5": False
}
```

### Customer Migration Tool (sitesfromexstcust)
From `sitesfromexstcust/ProjectModules/customer_functions.py`:
```python
path: str = "/xcloud/v1/customers"
header = xcloud_header(api_secret, service_id, path=path, method="GET")
result = requests.get(url=f"{url}{path}", headers=header)
```

## Use Cases
- **Device Registration**: List customers for device assignment
- **Data Export**: Export customer data for migration tools
- **Administration**: View all customers for management purposes
- **Integration**: Sync customer data with external systems

## Related Endpoints
- [POST /xcloud/v1/customers](v1-customers-post.md) - Register new customer
- [GET /xcloud/v1/customers/{customerId}](v1-customers-customerId-get.md) - Get specific customer
- [PUT /xcloud/v1/customers/{customerId}](v1-customers-customerId-put.md) - Update customer
- [GET /xcloud/v1.1/customers?status=INACTIVE](v1-1-customers-inactive-get.md) - Get inactive customers