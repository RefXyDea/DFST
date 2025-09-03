# /xcloud/v2/eventstore

## Overview
The v2 eventstore is an enhanced API system for IoT data processing in XCloud, providing improved data structures and processing capabilities compared to v1 eventstore operations. The v2 endpoints support structured data for things, datastreams, observations, and alarms.

## Base Path
- **Path**: `/xcloud/v2/eventstore`
- **Version**: 2.0
- **Authentication**: Required (HMAC-SHA256, md5=True for POST operations)

## Key Features
- **Enhanced Data Structure**: Improved organization and metadata support
- **Batch Processing**: Multiple records in single requests
- **Better Error Handling**: Detailed validation and processing feedback
- **OGC SensorThings Compatibility**: Aligned with IoT standards
- **Structured Relationships**: Clear linkage between things, datastreams, and observations

## Endpoint Categories

### 1. Things (Device/Entity Management)
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v2/eventstore/data/parsed/things`](v2-eventstore-data-parsed-things-post.md) | POST | Register and update IoT devices/entities | vig_orbcomm |

### 2. Datastreams (Data Channel Management) 
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v2/eventstore/data/parsed/datastreams`](v2-eventstore-data-parsed-datastreams-post.md) | POST | Define data channels for observations | vig_orbcomm |

### 3. Observations (Sensor Data)
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v2/eventstore/data/parsed/observations`](v2-eventstore-data-parsed-observations-post.md) | POST | Submit sensor measurements and readings | vig_tcp, vig_iridium, vig_rest, vig_updater, vig_orbcomm |

### 4. Alarms (Alert Data)
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v2/eventstore/data/parsed/alarms`](v2-eventstore-data-parsed-alarms-post.md) | POST | Submit alarm and alert events | vig_orbcomm |

## Data Flow Architecture

```
IoT Devices → VIG Services → v2/eventstore → Event Processing → Subscribers
     ↓              ↓             ↓               ↓              ↓
  Sensors      Data          Structured      Validation     Webhooks
              Collection     Processing      & Storage     & Alerts
```

## Usage in Codebase

### Production Services
- **vig_tcp**: Posts observations using v2 endpoint for enhanced data processing
- **vig_iridium**: Satellite communication data via v2 observations
- **vig_rest**: REST-based data ingestion using v2 endpoints
- **vig_updater**: Firmware update data processing via v2
- **vig_orbcomm**: Comprehensive v2 usage for all data types (things, datastreams, observations, alarms)

### Configuration Pattern
VIG services are configured to use specific v2 endpoints based on data type:
```python
# From vig_tcp/ProjectModules/post_data.py
path = "/xcloud/v2/eventstore/data/parsed/observations"

# From vig_orbcomm/vig_library/xcloud.py  
"v2_post_things": {"path":"/xcloud/v2/eventstore/data/parsed/things", "verb":"POST", "md5":True}
"v2_post_datastreams": {"path":"/xcloud/v2/eventstore/data/parsed/datastreams", "verb":"POST", "md5":True}
"v2_post_observations": {"path":"/xcloud/v2/eventstore/data/parsed/observations", "verb":"POST", "md5":True}
"v2_post_alarms": {"path":"/xcloud/v2/eventstore/data/parsed/alarms", "verb":"POST", "md5":True}
```

## v2 vs v1 Comparison

### v2 Advantages
- **Structured Data**: Better organized hierarchical data model
- **Enhanced Metadata**: Rich context and relationship information
- **Batch Operations**: Multiple records per request for efficiency
- **Validation**: Improved data validation and error reporting
- **Standards Compliance**: Aligned with OGC SensorThings API standards

### Migration Path
The system is transitioning from v1 to v2:
- **v1 Legacy**: `/xcloud/v1/eventstore/data/parsed` - Simple data posting
- **v2 Enhanced**: `/xcloud/v2/eventstore/data/parsed/*` - Structured data with metadata

## Authentication & Security
- **HMAC-SHA256**: Required for all POST operations
- **Content-MD5**: Required for data integrity validation (md5=True)
- **API Keys**: Service-specific authentication
- **TLS/SSL**: Encrypted transport layer

## Error Handling
V2 endpoints provide detailed error information:
```json
{
  "status": "PARTIALLY_PROCESSED",
  "recordsProcessed": 10,
  "recordsAccepted": 8,
  "recordsRejected": 2,
  "errors": [
    {
      "recordId": "record-001",
      "error": "VALIDATION_ERROR",
      "message": "Invalid timestamp format"
    }
  ]
}
```

## Performance Considerations
- **Batching**: Submit multiple records in single requests
- **Compression**: Enable HTTP compression for large payloads
- **Retry Logic**: Implement exponential backoff for failed requests
- **Rate Limiting**: Respect API rate limits and quotas

## Related Documentation
- [v1 EventStore Data Parsed](v1-eventstore-data-parsed-post.md) - Legacy endpoint
- [v1 EventStore Data Raw](v1-eventstore-data-raw-post.md) - Raw data submission
- [EventStore Subscriptions](v1-eventstore-subscriptions-parsed-post.md) - Event subscription system