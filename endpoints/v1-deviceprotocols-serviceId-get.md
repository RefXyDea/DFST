# GET /xcloud/v1/deviceprotocols/{serviceId}

## Overview
Retrieves details of a specific device protocol by its service ID.

## Endpoint Details
- **Path**: `/xcloud/v1/deviceprotocols/{serviceId}`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **serviceId**: The unique identifier of the device protocol service

## Response
### Success Response (200 OK)
```json
{
  "serviceId": "string",
  "deviceType": "vig_dps",
  "protocolName": "string",
  "version": "string",
  "dataFormat": {
    "type": "JSON",
    "schema": {}
  },
  "status": "ACTIVE",
  "createdAt": "2024-01-01T00:00:00Z",
  "lastModified": "2024-01-01T00:00:00Z"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Device protocol not found",
  "serviceId": "string"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Get specific protocol configuration
- **vig_package**: Protocol lookup by service ID

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_dps": {"path":"/xcloud/v1/deviceprotocols/{serviceId}", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/deviceprotocols](v1-deviceprotocols-get.md) - List all protocols
- [GET /xcloud/v1/deviceprotocols/{deviceType}](v1-deviceprotocols-deviceType-get.md) - Get by device type
- [DELETE /xcloud/v1/deviceprotocols/{serviceId}](v1-deviceprotocols-serviceId-delete.md) - Delete protocol