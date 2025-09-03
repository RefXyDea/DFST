# GET /xcloud/v1/devices?status={status}&deviceIds=FST{imei}

## Overview
Queries devices by IMEI using the FST device ID format and status filter.

## Endpoint Details
- **Path**: `/xcloud/v1/devices`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Query Parameters
- **status**: Device status to filter by (ACTIVE, INACTIVE, etc.)
- **deviceIds**: Device ID in FST format (FST followed by IMEI)

## Example URLs
```
/xcloud/v1/devices?status=ACTIVE&deviceIds=FST300234030000001
/xcloud/v1/devices?status=INACTIVE&deviceIds=FST300234030000007
```

## Response
### Success Response (200 OK)
```json
{
  "devices": [
    {
      "deviceId": "FST300234030000001",
      "customerId": "xyleminc",
      "deviceType": "xylemFst",
      "status": "ACTIVE",
      "imei": "300234030000001",
      "lastSeen": "2024-01-01T12:00:00Z"
    }
  ],
  "count": 1
}
```

## Usage in Codebase

### FST Services
- **fst_help**: Device registry helper functions for IMEI-based lookups

### Usage Pattern
From `fst_help` service - used for:
1. **IMEI Validation**: Check if device with specific IMEI exists
2. **Status Verification**: Ensure device is in expected state
3. **Registration Checks**: Verify device registration before operations

### Java Example (fst_help)
```java
// Device ID format: FST + IMEI
String deviceId = "FST" + imei;
String query = "?status=" + status + "&deviceIds=" + deviceId;
String url = "/xcloud/v1/devices" + query;
```

### IMEI to Device ID Conversion
- **Input IMEI**: 300234030000001
- **FST Device ID**: FST300234030000001
- **Query**: `?status=ACTIVE&deviceIds=FST300234030000001`

## Related Endpoints
- [GET /xcloud/v1/devices/{customerId}/{deviceId}](v1-devices-customerId-deviceId-get.md) - Get full device details
- [GET /xcloud/v1/devices?status=ACTIVE&deviceIds={deviceId}](v1-devices-active-get.md) - Active device check