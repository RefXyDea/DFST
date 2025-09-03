# GET /xcloud/v1/transports/{serviceId}

## Overview
Retrieves details of a specific transport service by its service ID.

## Endpoint Details
- **Path**: `/xcloud/v1/transports/{serviceId}`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **serviceId**: The unique identifier of the transport service

## Response
### Success Response (200 OK)
```json
{
  "serviceId": "string",
  "serviceName": "string",
  "transportType": "string",
  "connectionDetails": {
    "protocol": "string",
    "port": "number"
  },
  "status": "ACTIVE",
  "createdAt": "2024-01-01T00:00:00Z",
  "lastModified": "2024-01-01T00:00:00Z"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Transport service not found",
  "serviceId": "string"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Get specific transport configuration
- **vig_package**: Transport service lookup

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_ts": {"path":"/xcloud/v1/transports/{serviceId}", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/transports](v1-transports-get.md) - List all transport services
- [DELETE /xcloud/v1/transports/{serviceId}](v1-transports-serviceId-delete.md) - Delete this transport