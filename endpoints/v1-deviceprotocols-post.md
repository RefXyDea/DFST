# POST /xcloud/v1/deviceprotocols

## Overview
Registers a new device protocol with XCloud. Device protocols define how to interpret and process data from specific device types.

## Endpoint Details
- **Path**: `/xcloud/v1/deviceprotocols`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Optional (auth:false in configuration)
- **MD5**: Required (md5:true)

## Request Body
```json
{
  "serviceId": "string",
  "deviceType": "vig_dps",
  "protocolName": "string",
  "version": "string",
  "dataFormat": {
    "type": "JSON",
    "schema": {}
  }
}
```

## Response
### Success Response (200 OK)
```json
{
  "serviceId": "string",
  "deviceType": "vig_dps",
  "status": "REGISTERED",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Registers protocols for ORBCOMM devices
- **vig_package**: Protocol registration utilities

### Common Device Types
- `vig_dps`: VIG data processing service devices
- `xylemFst`: Xylem FST pump controllers

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "register_dps": {"path":"/xcloud/v1/deviceprotocols", "verb":"POST", "md5":True, "auth":False}
}
```

### Device Type Examples
```python
# From vig_tcp/ProjectModules/legacy_packet.py
"deviceType": "vig_dps"

# From fst_remote_control test data
"deviceType": "xylemFst"
```

## Related Endpoints
- [GET /xcloud/v1/deviceprotocols](v1-deviceprotocols-get.md) - List all protocols
- [GET /xcloud/v1/deviceprotocols/{deviceType}](v1-deviceprotocols-deviceType-get.md) - Get protocol by device type