# POST /xcloud/v1/devices

## Overview
Registers a new IoT device with XCloud for data collection and monitoring.

## Endpoint Details
- **Path**: `/xcloud/v1/devices`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body
```json
{
  "deviceId": "FST300234030000001",
  "customerId": "xyleminc",
  "deviceType": "xylemFst",
  "name": "Pump Station 1",
  "location": {
    "latitude": 40.7128,
    "longitude": -74.0060
  },
  "properties": {
    "serialNumber": "string",
    "model": "string"
  }
}
```

## Response
### Success Response (200 OK)
```json
{
  "deviceId": "FST300234030000001",
  "customerId": "xyleminc",
  "status": "REGISTERED",
  "thingId": 12345,
  "createdAt": "2024-01-01T00:00:00Z"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Registers devices from satellite communication
- **vig_package**: Device registration utilities

### Device ID Format
- FST devices: `FST{imei}` (e.g., FST300234030000001)
- Timestamp-based: `FST-{timestamp}-{id}`

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "register_device": {"path":"/xcloud/v1/devices", "verb":"POST", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/devices](v1-devices-get.md) - List all devices
- [GET /xcloud/v1/devices/{customerId}/{deviceId}](v1-devices-customerId-deviceId-get.md) - Get device details