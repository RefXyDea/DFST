# GET /xcloud/v1/devices?top={top}&skip={skip}

## Overview
Retrieves devices using alternative OData-style pagination parameters.

## Endpoint Details
- **Path**: `/xcloud/v1/devices`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Query Parameters
- **top**: Number of items to return (equivalent to size/limit)
- **skip**: Number of items to skip (equivalent to offset)
- **status** (optional): Filter by device status
- **customerId** (optional): Filter by customer ID

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
      "lastSeen": "2024-01-01T00:00:00Z"
    }
  ],
  "count": 12144,
  "nextLink": "https://gc-xc-api-gateway.xylem-cloud.com/xcloud/v1/devices?status=ACTIVE&top=2&skip=2"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Device pagination for large datasets
- **vig_package**: Paginated device retrieval

### Test Data Example
From `fst_observation_service/src/test/java/com/xylem/dewatering/oms/adapter/ServiceExecutorTests.java`:
```json
{
  "count": 12144, 
  "nextLink": "https://gc-xc-api-gateway.xylem-cloud.com/xcloud/v1/devices?status=ACTIVE&top=2&skip=2"
}
```

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_device_all": {"path":"/xcloud/v1/devices", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/devices](v1-devices-get.md) - Standard pagination
- [GET /xcloud/v1/devices/{customerId}/{deviceId}](v1-devices-customerId-deviceId-get.md) - Get specific device