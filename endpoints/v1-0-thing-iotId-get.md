# GET /xcloud/v1.0/Things({iot_id})

## Overview
Retrieves a specific IoT device/entity by its unique IoT ID using the OGC SensorThings API v1.0 standard.

## Endpoint Details
- **Path**: `/xcloud/v1.0/Things({iot_id})`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required
- **Standard**: OGC SensorThings API v1.0

## Path Parameters
- **iot_id** (string, required): The unique IoT identifier of the thing

## Response
### Success Response (200 OK)
```json
{
  "@iot.id": "12345",
  "name": "CD100M Pump Station",
  "description": "Dewatering pump with sensors",
  "properties": {
    "serialNumber": "SN123456",
    "model": "CD100M",
    "manufacturer": "Xylem",
    "customerId": "FST-customer-001"
  },
  "Datastreams": [
    {
      "@iot.id": "ds-001",
      "name": "Water Level",
      "unitOfMeasurement": {
        "name": "Meters",
        "symbol": "m",
        "definition": "http://www.qudt.org/qudt/owl/1.0.0/unit/Meter"
      }
    }
  ],
  "Locations": [
    {
      "@iot.id": "loc-001",
      "name": "Pump Station Location",
      "location": {
        "type": "Point",
        "coordinates": [-74.0060, 40.7128]
      }
    }
  ]
}
```

## Usage in Codebase
- **vig_orbcomm**: Device detail retrieval
- **vig_package**: OGC SensorThings device management

## Related Endpoints
- [GET /xcloud/v1.0/Things](v1-0-things-get.md) - List all things
- [GET /xcloud/v1.0/Things({iot_id})/Datastreams](v1-0-things-iotId-datastreams-get.md) - Get datastreams
