# GET /xcloud/v1.0/Things

## Overview
Retrieves all IoT devices/entities using the OGC SensorThings API v1.0 standard.

## Endpoint Details
- **Path**: `/xcloud/v1.0/Things`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required
- **Standard**: OGC SensorThings API v1.0

## Response
### Success Response (200 OK)
```json
{
  "value": [
    {
      "@iot.id": "12345",
      "name": "CD100M Pump Station",
      "description": "Dewatering pump with sensors",
      "properties": {
        "serialNumber": "SN123456",
        "model": "CD100M",
        "manufacturer": "Xylem"
      },
      "Datastreams@iot.navigationLink": "/xcloud/v1.0/Things(12345)/Datastreams",
      "Locations@iot.navigationLink": "/xcloud/v1.0/Things(12345)/Locations"
    }
  ],
  "@iot.nextLink": "/xcloud/v1.0/Things?$skip=100"
}
```

## Usage in Codebase
- **vig_orbcomm**: Device management and data collection
- **vig_package**: OGC SensorThings utilities
- **fst_alarm (test)**: Device testing with OGC standard

## Related Endpoints
- [GET /xcloud/v1.0/Things({iot_id})](v1-0-thing-iotId-get.md) - Get specific thing
- [GET /xcloud/v1.0/Things({iot_id})/Datastreams](v1-0-things-iotId-datastreams-get.md) - Get thing datastreams
