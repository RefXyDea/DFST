# GET /xcloud/v1.1/customers?status=INACTIVE

## Overview
Retrieves a list of customers with INACTIVE status using the v1.1 API. This enhanced endpoint provides additional filtering capabilities compared to the basic v1 customer listing.

## Endpoint Details
- **Path**: `/xcloud/v1.1/customers?status=INACTIVE`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required
- **Version**: v1.1 (Enhanced API)

## Query Parameters
- **status** (string, required): Filter by customer status. Value: "INACTIVE"
- **limit** (integer, optional): Maximum number of customers to return
- **offset** (integer, optional): Number of customers to skip for pagination

## Response
### Success Response (200 OK)
```json
[
  {
    "customerId": "FST-1536312680993-InactiveCustomer",
    "customerName": "Defunct Water Services",
    "status": "INACTIVE",
    "createdAt": "2023-01-01T10:30:00Z",
    "deactivatedAt": "2024-01-01T15:30:00Z",
    "contactInfo": {
      "email": "admin@defunct-water.com",
      "phone": "+1-555-0000"
    },
    "statistics": {
      "deviceCount": 15,
      "activeDevices": 0,
      "lastActivity": "2023-12-31T23:59:59Z"
    },
    "deactivationReason": "Contract expired"
  }
]
```

### Empty Response (200 OK)
```json
[]
```

## Usage in Codebase

### Test Services
- **fst_location (test)**: Testing inactive customer retrieval and filtering

### Test Examples (fst_location)
From `fst_location/src/test/java/com/xylem/dewatering/lms/XCloudTest.java`:
```java
String requestUrl = "/xcloud/v1.1/customers?status=INACTIVE";
URI uri = URI.create("https://xcloudqa.dev1-sensus-analytics.com/xcloud/v1.1/customers?status=INACTIVE");
```

## v1.1 API Features
- **Enhanced Filtering**: More sophisticated status filtering
- **Extended Metadata**: Additional customer information
- **Improved Pagination**: Better pagination support
- **Audit Information**: Deactivation timestamps and reasons

## Use Cases
- **Cleanup Operations**: Identify inactive customers for data archival
- **Reporting**: Generate reports on customer churn and retention
- **Billing**: Process final billing for inactive customers
- **Compliance**: Maintain records of inactive customer data
- **Re-engagement**: Identify candidates for win-back campaigns

## Status Values
- **INACTIVE**: Customers who have been deactivated
- **ACTIVE**: Active customers (use regular v1 endpoint)
- **SUSPENDED**: Temporarily suspended customers

## Response Fields
- **deactivatedAt**: Timestamp when customer was deactivated
- **deactivationReason**: Reason for deactivation
- **lastActivity**: Last recorded activity before deactivation
- **activeDevices**: Should be 0 for inactive customers

## Related Endpoints
- [GET /xcloud/v1/customers](v1-customers-get.md) - List all customers (v1)
- [GET /xcloud/v1/customers/{customerId}](v1-customers-customerId-get.md) - Get specific customer
- [PUT /xcloud/v1/customers/{customerId}](v1-customers-customerId-put.md) - Reactivate customer
- [POST /xcloud/v1/customers](v1-customers-post.md) - Register new customer