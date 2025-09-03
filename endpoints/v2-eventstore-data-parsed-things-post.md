# POST /xcloud/v2/eventstore/data/parsed/things

## Overview
Posts IoT "Things" data to XCloud EventStore using the enhanced v2 API. Things represent physical devices in the OGC SensorThings model.

## Endpoint Details
- **Path**: `/xcloud/v2/eventstore/data/parsed/things`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body
```json
{
  "things": [
    {
      "@iot.id": 2235,
      "name": "FST300234030000001",
      "description": "Xylem FST Pump Controller",
      "properties": {
        "serialNumber": "300234030000001",
        "model": "FST-2000"
      },
      "customerId": "047",
      "sensusID": "FST300234030000001@047"
    }
  ]
}
```

## Response
### Success Response (200 OK)
```json
{
  "status": "ACCEPTED",
  "thingsProcessed": 1,
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Usage in Codebase

### VIG Services (Production)
- **vig_orbcomm**: Posts thing definitions for ORBCOMM devices

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "post_things": {"path":"/xcloud/v2/eventstore/data/parsed/things", "verb":"POST", "md5":True}
}
```

### Thing Properties
- **@iot.id**: Unique thing identifier
- **name**: Device name (usually device ID)
- **customerId**: Customer identifier
- **sensusID**: Format: {deviceId}@{customerId}

## Related Endpoints
- [POST /xcloud/v2/eventstore/data/parsed/datastreams](v2-eventstore-data-parsed-datastreams-post.md) - Post datastreams
- [POST /xcloud/v2/eventstore/data/parsed/observations](v2-eventstore-data-parsed-observations-post.md) - Post observations