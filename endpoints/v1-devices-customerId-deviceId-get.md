# GET /xcloud/v1/devices/{customerId}/{deviceId}

## Overview
Retrieves details of a specific device by customer ID and device ID.

## Endpoint Details
- **Path**: `/xcloud/v1/devices/{customerId}/{deviceId}`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **customerId**: The customer identifier (e.g., "xyleminc")
- **deviceId**: The device identifier (e.g., "FST300234030000007")

## Response
### Success Response (200 OK)
```json
{
  "deviceId": "FST300234030000007",
  "customerId": "xyleminc",
  "deviceType": "xylemFst",
  "name": "Pump Station 7",
  "status": "ACTIVE",
  "location": {
    "latitude": 40.7128,
    "longitude": -74.0060
  },
  "properties": {
    "serialNumber": "string",
    "model": "string",
    "firmware": "1.2.3"
  },
  "thingId": 47,
  "createdAt": "2024-01-01T00:00:00Z",
  "lastSeen": "2024-01-01T12:00:00Z"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Device not found",
  "customerId": "xyleminc",
  "deviceId": "FST300234030000007"
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Device lookup for data processing
- **vig_package**: Device information retrieval
- **fst_help**: Device registry helper functions

### Test Services
- **fst_alarm (test)**: Device verification in tests

### Java Test Example
From `fst_alarm/src/test/java/com/xylem/dewatering/alarm/AlarmDeviceTest.java:57`:
```java
String requestUrl = "/xcloud/v1/devices/xyleminc/FST300234030000007";
URI uri = URI.create("https://gc-xc-api-gateway.xylem-cloud.com/xcloud/v1/devices/xyleminc/FST300234030000007");
```

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_device": {"path":"/xcloud/v1/devices/{customerId}/{deviceId}", "verb":"GET", "md5":False}
}
```

### Usage Pattern
This endpoint is commonly used to:
1. Verify device exists before processing data
2. Get device configuration for data parsing
3. Retrieve device metadata for alarm processing

## Related Endpoints
- [PATCH /xcloud/v1/devices/{customerId}/{deviceId}](v1-devices-customerId-deviceId-patch.md) - Update device
- [GET /xcloud/v1/devices](v1-devices-get.md) - List all devices