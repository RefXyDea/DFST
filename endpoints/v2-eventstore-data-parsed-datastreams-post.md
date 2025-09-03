# POST /xcloud/v2/eventstore/data/parsed/datastreams

## Overview
Posts datastream definitions to XCloud EventStore using the v2 API. Datastreams represent sensor channels within IoT devices.

## Endpoint Details
- **Path**: `/xcloud/v2/eventstore/data/parsed/datastreams`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body
```json
{
  "datastreams": [
    {
      "@iot.id": 1141456,
      "name": "Temperature Sensor",
      "description": "Primary temperature measurement",
      "observationType": "OM_Measurement",
      "unitOfMeasurement": {
        "name": "Celsius",
        "symbol": "°C",
        "definition": "http://www.qudt.org/qudt/owl/1.0.0/unit/Instances.html#DegreeCelsius"
      },
      "thing": {
        "@iot.id": 2235
      },
      "sensor": {
        "@iot.id": 1001,
        "name": "TempSensor01"
      },
      "observedProperty": {
        "@iot.id": 501,
        "name": "Temperature"
      },
      "sensusID": "Q4000_AI0_0-1024@analogInput@FST300234030000001@047"
    }
  ]
}
```

## Response
### Success Response (200 OK)
```json
{
  "status": "ACCEPTED",
  "datastreamsProcessed": 1,
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Usage in Codebase

### VIG Services (Production)
- **vig_orbcomm**: Posts datastream configurations for ORBCOMM devices

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "post_datastreams": {"path":"/xcloud/v2/eventstore/data/parsed/datastreams", "verb":"POST", "md5":True}
}
```

### Datastream Properties
- **@iot.id**: Unique datastream identifier
- **sensusID**: Format: {sensor}@{input}@{deviceId}@{customerId}
- **observationType**: Type of measurement (OM_Measurement, OM_CategoryObservation, etc.)
- **unitOfMeasurement**: Units for the measurements

### Common Observation Types
- OM_Measurement: Numeric measurements
- OM_CategoryObservation: Categorical data
- OM_CountObservation: Count-based data

## Related Endpoints
- [POST /xcloud/v2/eventstore/data/parsed/things](v2-eventstore-data-parsed-things-post.md) - Post things (devices)
- [POST /xcloud/v2/eventstore/data/parsed/observations](v2-eventstore-data-parsed-observations-post.md) - Post observations for datastreams