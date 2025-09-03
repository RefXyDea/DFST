# POST /xcloud/v1/eventstore/data/raw

## Overview
Posts raw, unprocessed data to XCloud EventStore. This is typically the first step in the data pipeline before parsing.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/data/raw`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body
```json
{
  "deviceId": "FST300234030000001",
  "customerId": "047",
  "transportType": "TCP",
  "dataType": "SENSOR_DATA",
  "deviceType": "vig_dps",
  "payload": "raw_binary_or_hex_data",
  "timestamp": "2024-01-01T12:00:00Z",
  "metadata": {
    "source": "TCP",
    "port": 8080,
    "protocol": "v1"
  }
}
```

## Response
### Success Response (200 OK)
```json
{
  "status": "ACCEPTED",
  "rawDataId": "string",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Usage in Codebase

### VIG Services (Production)
All VIG data ingestion services use this endpoint:

- **vig_tcp**: Raw TCP packet data
- **vig_iridium**: Raw satellite messages
- **vig_rest**: Raw REST payloads
- **vig_updater**: Raw firmware update data
- **vig_orbcomm**: Raw ORBCOMM messages
- **vig_package**: Shared raw data utilities

### Python Example (vig_tcp)
From `vig_tcp/ProjectModules/post_data.py:41`:
```python
path = "/xcloud/v1/eventstore/data/raw"

def post_raw_data(raw_payload):
    # Posts raw data to XCloud v1 endpoint
    response = make_request(path, "POST", raw_payload)
    return response
```

### Python Example (vig_iridium)
From `vig_iridium/ProjectModules/post_data.py:40`:
```python
path = "/xcloud/v1/eventstore/data/raw"
# Similar usage for satellite raw data
```

### Data Pipeline Flow
1. **IoT Device** → Sends raw data via transport (TCP, satellite, etc.)
2. **VIG Service** → Receives raw data
3. **XCloud v1 Raw API** → Stores raw data in EventStore
4. **Data Processing** → Raw data is parsed into structured format
5. **XCloud v2 Parsed API** → Parsed data stored as observations/things

### Raw Data Types
- Binary sensor readings
- Hex-encoded messages
- Compressed data packets
- Encrypted payloads
- Protocol-specific formats

## Related Endpoints
- [POST /xcloud/v2/eventstore/data/parsed/observations](v2-eventstore-data-parsed-observations-post.md) - Post parsed observations
- [POST /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-post.md) - Subscribe to raw data events