# GET /xcloud/v1/devices

## Overview
Retrieves a list of all registered devices from XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/devices`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Query Parameters
- **status** (optional): Filter by device status (ACTIVE, INACTIVE)
- **customerId** (optional): Filter by customer ID
- **deviceType** (optional): Filter by device type
- **page** (optional): Page number for pagination
- **size** (optional): Number of items per page

## Response
### Success Response (200 OK)
```json
{
  "devices": [
    {
      "deviceId": "FST300234030000001",
      "customerId": "xyleminc",
      "deviceType": "xylemFst",
      "name": "Pump Station 1",
      "status": "ACTIVE",
      "location": {
        "latitude": 40.7128,
        "longitude": -74.0060
      },
      "lastSeen": "2024-01-01T00:00:00Z"
    }
  ],
  "totalCount": 150,
  "page": 0,
  "size": 20
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Lists devices for data processing
- **vig_package**: Device discovery

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_device_all": {"path":"/xcloud/v1/devices", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [POST /xcloud/v1/devices](v1-devices-post.md) - Register new device
- [GET /xcloud/v1/devices?top={top}&skip={skip}](v1-devices-paginated-get.md) - Get with alternative pagination