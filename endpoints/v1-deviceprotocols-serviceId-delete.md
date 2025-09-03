# DELETE /xcloud/v1/deviceprotocols/{serviceId}

## Overview
Deletes a registered device protocol from XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/deviceprotocols/{serviceId}`
- **Method**: DELETE
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **serviceId**: The unique identifier of the device protocol to delete

## Response
### Success Response (200 OK)
```json
{
  "message": "Device protocol deleted successfully",
  "serviceId": "string"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Device protocol not found",
  "serviceId": "string"
}
```

### Error Response (409 Conflict)
```json
{
  "error": "Cannot delete protocol with active devices",
  "activeDevices": 10
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Cleanup device protocols
- **vig_package**: Protocol management

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "delete_dps": {"path":"/xcloud/v1/deviceprotocols/{serviceId}", "verb":"DELETE", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/deviceprotocols](v1-deviceprotocols-get.md) - List all protocols
- [GET /xcloud/v1/deviceprotocols/{serviceId}](v1-deviceprotocols-serviceId-get.md) - Get protocol details