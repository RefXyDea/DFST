# POST /xcloud/v2/eventstore/data/parsed/observations

## Overview
Posts parsed observation data to XCloud EventStore using the enhanced v2 API format. This is the primary endpoint for sending IoT sensor data.

## Endpoint Details
- **Path**: `/xcloud/v2/eventstore/data/parsed/observations`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body
```json
{
  "observations": [
    {
      "phenomenonTime": "2024-01-01T12:00:00Z",
      "result": 25.6,
      "resultTime": "2024-01-01T12:00:00Z",
      "datastream": {
        "@iot.id": 1141456,
        "name": "Temperature Sensor"
      },
      "featureOfInterest": {
        "@iot.id": 2235,
        "name": "Pump Location"
      }
    }
  ],
  "deviceId": "FST300234030000001",
  "customerId": "047",
  "batchType": "OBSERVATIONS"
}
```

## Response
### Success Response (200 OK)
```json
{
  "status": "ACCEPTED",
  "observationsProcessed": 1,
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Usage in Codebase

### VIG Services (Production)
All VIG services actively use this endpoint for posting sensor observations:

- **vig_tcp**: TCP-based data ingestion
- **vig_iridium**: Satellite communication data
- **vig_rest**: REST API data submission  
- **vig_updater**: Firmware update telemetry
- **vig_orbcomm**: ORBCOMM satellite data

### Python Example (vig_tcp)
From `vig_tcp/ProjectModules/post_data.py:23`:
```python
path = "/xcloud/v2/eventstore/data/parsed/observations"

def post_observations(data):
    # Posts observation data to XCloud v2 endpoint
    response = make_request(path, "POST", data)
    return response
```

### Python Example (vig_iridium) 
From `vig_iridium/ProjectModules/post_data.py:22`:
```python
path = "/xcloud/v2/eventstore/data/parsed/observations"
# Similar usage for satellite-based observations
```

### Data Flow
1. **IoT Device** → Sends raw sensor data via TCP/satellite
2. **VIG Service** → Parses raw data into observations
3. **XCloud v2 API** → Stores observations in EventStore
4. **Downstream Services** → Subscribe to observation events

### Observation Types
- Temperature readings
- Pressure measurements  
- Flow rates
- Device status indicators
- Alarm conditions

## Related Endpoints
- [POST /xcloud/v1/eventstore/data/raw](v1-eventstore-data-raw-post.md) - Post raw data (v1)
- [POST /xcloud/v2/eventstore/data/parsed/things](v2-eventstore-data-parsed-things-post.md) - Post things data