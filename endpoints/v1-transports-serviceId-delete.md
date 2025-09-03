# DELETE /xcloud/v1/transports/{serviceId}

## Overview
Deletes a registered transport service from XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/transports/{serviceId}`
- **Method**: DELETE
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **serviceId**: The unique identifier of the transport service to delete

## Response
### Success Response (200 OK)
```json
{
  "message": "Transport service deleted successfully",
  "serviceId": "string"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Transport service not found",
  "serviceId": "string"
}
```

### Error Response (409 Conflict)
```json
{
  "error": "Cannot delete transport service with active connections",
  "activeConnections": 5
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Cleanup transport services
- **vig_package**: Transport service management

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "delete_ts": {"path":"/xcloud/v1/transports/{serviceId}", "verb":"DELETE", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/transports](v1-transports-get.md) - List all transport services
- [GET /xcloud/v1/transports/{serviceId}](v1-transports-serviceId-get.md) - Get transport details