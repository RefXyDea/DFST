# /xcloud/v1.1/devices

## Overview
Enhanced device management endpoints using API version 1.1 with additional features and improved data structures.

## Endpoint Details
- **Path**: `/xcloud/v1.1/devices`
- **Method**: Various (GET, POST, PATCH, DELETE)
- **Authentication**: Required (HMAC-SHA256)
- **API Version**: 1.1 (Enhanced)

## Supported Operations
- GET: List devices with enhanced filtering
- POST: Register devices with v1.1 schema
- PATCH: Update devices with additional fields
- DELETE: Remove devices

## Enhanced Features in v1.1
- **Extended Metadata**: Additional device properties
- **Advanced Filtering**: More query options
- **Improved Pagination**: Better performance for large datasets
- **Bulk Operations**: Support for batch device operations

## Response Format (Enhanced)
### Success Response (200 OK)
```json
{
  "devices": [
    {
      "deviceId": "FST300234030000001",
      "customerId": "xyleminc",
      "deviceType": "xylemFst",
      "status": "ACTIVE",
      "metadata": {
        "version": "1.1",
        "capabilities": [],
        "configuration": {}
      },
      "location": {
        "latitude": 40.7128,
        "longitude": -74.0060,
        "address": "string",
        "timezone": "UTC"
      },
      "connectivity": {
        "protocol": "string",
        "lastSeen": "2024-01-01T12:00:00Z",
        "signalStrength": -70
      }
    }
  ],
  "pagination": {
    "total": 150,
    "page": 0,
    "size": 20,
    "hasMore": true
  }
}
```

## Usage in Codebase

### FST Services
- **fst_device_management_service**: Primary user of v1.1 device endpoints

### Java Constant
From `fst_device_management_service/src/main/java/com/xylem/dewatering/dms/common/constants/Constants.java:17`:
```java
public static final String XCLOUD_VERSION = "/xcloud/v1.1";
```

### Use Cases in Device Management Service
1. **Device Registration**: Register new devices with enhanced metadata
2. **Fleet Management**: Bulk device operations
3. **Configuration Management**: Update device settings
4. **Status Monitoring**: Enhanced device health tracking

## Migration from v1 to v1.1
- **Backward Compatible**: v1 responses still supported
- **Additional Fields**: New optional fields in responses
- **Enhanced Filtering**: More query parameters available
- **Performance**: Optimized for large device fleets

## Related Endpoints
- [GET /xcloud/v1/devices](v1-devices-get.md) - Standard v1 device listing
- [POST /xcloud/v1/devices](v1-devices-post.md) - v1 device registration