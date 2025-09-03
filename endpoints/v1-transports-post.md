# POST /xcloud/v1/transports

## Overview
Registers a new transport service with XCloud. Transport services handle the communication layer for IoT device data transmission.

## Endpoint Details
- **Path**: `/xcloud/v1/transports`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body
```json
{
  "serviceId": "string",
  "serviceName": "string",
  "transportType": "string",
  "connectionDetails": {
    "protocol": "string",
    "port": "number"
  }
}
```

## Response
### Success Response (200 OK)
```json
{
  "serviceId": "string",
  "status": "REGISTERED",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Registers ORBCOMM satellite transport
- **vig_package**: Shared transport registration utilities

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "register_ts": {"path":"/xcloud/v1/transports", "verb":"POST", "md5":False, "auth":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/transports](v1-transports-get.md) - List all transport services
- [DELETE /xcloud/v1/transports/{serviceId}](v1-transports-serviceId-delete.md) - Delete transport service