# GET /xcloud/v1/sensingsites

## Overview
Retrieves all sensing sites (locations where IoT devices are deployed) accessible to the authenticated service.

## Endpoint Details
- **Path**: `/xcloud/v1/sensingsites`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required

## Response
### Success Response (200 OK)
```json
[
  {
    "siteId": "site-001",
    "siteName": "Downtown Pumping Station",
    "location": {
      "latitude": 40.7128,
      "longitude": -74.0060,
      "address": "123 Industrial Ave, New York, NY"
    },
    "customerId": "FST-customer-001",
    "status": "ACTIVE",
    "deviceCount": 5,
    "lastActivity": "2024-01-02T15:30:00Z"
  }
]
```

## Usage in Codebase
- **sitesfromexstcust**: Site management and migration utilities

## Related Endpoints
- [POST /xcloud/v1/sensingsites](v1-sensingsites-post.md) - Create sensing site
- [GET /xcloud/v1/sensingsites/{siteId}](v1-sensingsites-siteId-get.md) - Get specific site
