# GET /xcloud/v1/deviceprotocols

## Overview
Retrieves a list of all registered device protocols from XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/deviceprotocols`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Query Parameters
- **page** (optional): Page number for pagination
- **size** (optional): Number of items per page
- **deviceType** (optional): Filter by device type

## Response
### Success Response (200 OK)
```json
{
  "protocols": [
    {
      "serviceId": "string",
      "deviceType": "vig_dps",
      "protocolName": "string",
      "version": "string",
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
- **vig_orbcomm**: Lists available device protocols
- **vig_package**: Protocol discovery

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_dps_all": {"path":"/xcloud/v1/deviceprotocols", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [POST /xcloud/v1/deviceprotocols](v1-deviceprotocols-post.md) - Register new protocol
- [GET /xcloud/v1/deviceprotocols/{serviceId}](v1-deviceprotocols-serviceId-get.md) - Get specific protocol