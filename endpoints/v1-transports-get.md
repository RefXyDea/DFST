# GET /xcloud/v1/transports

## Overview
Retrieves a list of all registered transport services from XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/transports`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Query Parameters
- **page** (optional): Page number for pagination
- **size** (optional): Number of items per page

## Response
### Success Response (200 OK)
```json
{
  "transports": [
    {
      "serviceId": "string",
      "serviceName": "string",
      "transportType": "string",
      "status": "ACTIVE",
      "createdAt": "2024-01-01T00:00:00Z"
    }
  ],
  "totalCount": 10,
  "page": 0,
  "size": 20
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Lists available transport services
- **vig_package**: Transport service discovery

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_ts_all": {"path":"/xcloud/v1/transports", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [POST /xcloud/v1/transports](v1-transports-post.md) - Register new transport service
- [GET /xcloud/v1/transports/{serviceId}](v1-transports-serviceId-get.md) - Get specific transport