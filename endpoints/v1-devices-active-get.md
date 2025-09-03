# GET /xcloud/v1/devices?status=ACTIVE&deviceIds={deviceId}

## Overview
Retrieves active device information by filtering for a specific device ID with ACTIVE status.

## Endpoint Details
- **Path**: `/xcloud/v1/devices`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Query Parameters
- **status**: Must be "ACTIVE"
- **deviceIds**: The specific device ID to query

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
      "lastSeen": "2024-01-01T12:00:00Z",
      "location": {
        "latitude": 40.7128,
        "longitude": -74.0060
      }
    }
  ],
  "count": 1
}
```

### Empty Response (200 OK)
```json
{
  "devices": [],
  "count": 0
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Verify device is active before processing data

### Python Example (vig_orbcomm)
```python
# Usage pattern for checking if device is active
device_id = "FST300234030000001"
response = xcloud_client.get(f"/xcloud/v1/devices?status=ACTIVE&deviceIds={device_id}")
if response.json().get("count", 0) > 0:
    # Device is active, proceed with data processing
    process_device_data()
```

### Use Cases
1. **Data Validation**: Verify device is active before accepting data
2. **Health Monitoring**: Check if device is still reporting
3. **Permission Checks**: Ensure device is authorized for data submission

## Related Endpoints
- [GET /xcloud/v1/devices/{customerId}/{deviceId}](v1-devices-customerId-deviceId-get.md) - Get full device details
- [GET /xcloud/v1/devices?status={status}&deviceIds=FST{imei}](v1-devices-imei-query-get.md) - Query by IMEI pattern