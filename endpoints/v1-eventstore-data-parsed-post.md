# POST /xcloud/v1/eventstore/data/parsed

## Overview
Posts parsed data to XCloud EventStore using the v1 API format.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/data/parsed`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body
```json
{
  "deviceId": "FST300234030000001",
  "customerId": "047",
  "deviceType": "vig_dps",
  "payload": {
    "observations": [],
    "things": [],
    "datastreams": []
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Response
### Success Response (200 OK)
```json
{
  "status": "ACCEPTED",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Usage in Codebase

### VIG Services (Production)
- **vig_orbcomm**: Posts parsed satellite data
- **vig_package**: Shared parsed data utilities

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "post_parsed": {"path":"/xcloud/v1/eventstore/data/parsed", "verb":"POST", "md5":True}
}
```

## Related Endpoints
- [POST /xcloud/v2/eventstore/data/parsed/observations](v2-eventstore-data-parsed-observations-post.md) - Enhanced v2 observations
- [POST /xcloud/v1/eventstore/data/raw](v1-eventstore-data-raw-post.md) - Post raw data