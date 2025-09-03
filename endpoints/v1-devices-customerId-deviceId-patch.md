# PATCH /xcloud/v1/devices/{customerId}/{deviceId}

## Overview
Updates an existing device registration in XCloud with new information.

## Endpoint Details
- **Path**: `/xcloud/v1/devices/{customerId}/{deviceId}`
- **Method**: PATCH
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **customerId**: The customer identifier
- **deviceId**: The device identifier

## Request Body
```json
{
  "name": "Updated Pump Station Name",
  "location": {
    "latitude": 40.7500,
    "longitude": -74.0100
  },
  "properties": {
    "firmware": "1.3.0",
    "lastMaintenance": "2024-01-01"
  },
  "status": "ACTIVE"
}
```

## Response
### Success Response (200 OK)
```json
{
  "deviceId": "FST300234030000001",
  "customerId": "xyleminc",
  "status": "UPDATED",
  "lastModified": "2024-01-01T00:00:00Z"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Device not found",
  "customerId": "xyleminc",
  "deviceId": "FST300234030000001"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Updates device information and status
- **vig_package**: Device management utilities

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "patch_device": {"path":"/xcloud/v1/devices/{customerId}/{deviceId}", "verb":"PATCH", "md5":False}
}
```

### Common Update Scenarios
1. **Location Updates**: When device is physically moved
2. **Firmware Updates**: After successful firmware upgrades
3. **Status Changes**: Activate/deactivate devices
4. **Configuration Updates**: Modify device settings

## Related Endpoints
- [GET /xcloud/v1/devices/{customerId}/{deviceId}](v1-devices-customerId-deviceId-get.md) - Get current device details
- [POST /xcloud/v1/devices](v1-devices-post.md) - Register new device