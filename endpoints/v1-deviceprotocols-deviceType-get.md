# GET /xcloud/v1/deviceprotocols/{deviceType}

## Overview
Retrieves the device protocol configuration for a specific device type. This endpoint allows fetching protocol definitions by device type classification rather than service ID.

## Endpoint Details
- **Path**: `/xcloud/v1/deviceprotocols/{deviceType}`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **deviceType**: The device type identifier (e.g., "vig_dps", "xylemFst")

## Response
### Success Response (200 OK)
```json
{
  "deviceType": "vig_dps",
  "protocols": [
    {
      "serviceId": "string",
      "protocolName": "string",
      "version": "string",
      "dataFormat": {
        "type": "JSON",
        "schema": {}
      },
      "status": "ACTIVE"
    }
  ]
}
```

### Error Response (404 Not Found)
```json
{
  "error": "No protocol found for device type",
  "deviceType": "string"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Get protocol by device type for data processing
- **vig_package**: Device type protocol lookup

### Common Device Types
- `vig_dps`: VIG data processing service (used by all VIG services)
- `xylemFst`: Xylem FST pump controllers

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_dps_deviceType": {"path":"/xcloud/v1/deviceprotocols/{deviceType}", "verb":"GET", "md5":False}
}
```

### Usage Context
This endpoint is used when services need to determine how to process data from a specific type of device without knowing the service ID. Each device type has an associated protocol that defines:
- Data format and schema
- Processing rules
- Validation requirements

## Related Endpoints
- [GET /xcloud/v1/deviceprotocols](v1-deviceprotocols-get.md) - List all protocols
- [GET /xcloud/v1/deviceprotocols/{serviceId}](v1-deviceprotocols-serviceId-get.md) - Get by service ID
- [POST /xcloud/v1/deviceprotocols](v1-deviceprotocols-post.md) - Register new protocol