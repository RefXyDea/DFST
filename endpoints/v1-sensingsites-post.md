# POST /xcloud/v1/sensingsites

## Overview
Creates a new sensing site in XCloud for deploying and managing IoT devices.

## Endpoint Details
- **Path**: `/xcloud/v1/sensingsites`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256, md5=True)

## Request Body
```json
{
  "siteName": "Downtown Pumping Station",
  "description": "Main municipal pumping facility",
  "location": {
    "latitude": 40.7128,
    "longitude": -74.0060,
    "address": "123 Industrial Ave, New York, NY"
  },
  "customerId": "FST-customer-001",
  "siteType": "PUMPING_STATION",
  "status": "ACTIVE"
}
```

## Usage in Codebase
- **sitesfromexstcust**: Site creation and migration

## Related Endpoints
- [GET /xcloud/v1/sensingsites](v1-sensingsites-get.md) - List all sites
