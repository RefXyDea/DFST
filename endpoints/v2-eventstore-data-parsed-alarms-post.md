# POST /xcloud/v2/eventstore/data/parsed/alarms

## Overview
Posts parsed alarm data to XCloud's v2 eventstore. This enhanced v2 endpoint provides improved data structure and processing for alarm events compared to the v1 eventstore endpoints.

## Endpoint Details
- **Path**: `/xcloud/v2/eventstore/data/parsed/alarms`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256, md5=True)

## Request Body
```json
{
  "batchId": "batch-alarms-20240101-001",
  "timestamp": "2024-01-01T10:30:00Z",
  "deviceId": "FST123456789",
  "customerId": "customer-001",
  "alarms": [
    {
      "alarmId": "alarm-001",
      "alarmType": "HIGH_LEVEL",
      "severity": "HIGH",
      "status": "ACTIVE",
      "triggeredAt": "2024-01-01T10:29:45Z",
      "description": "Water level above threshold",
      "thresholdValue": 85.0,
      "currentValue": 92.3,
      "unit": "percent",
      "location": {
        "latitude": 40.7128,
        "longitude": -74.0060
      },
      "deviceInfo": {
        "serialNumber": "SN123456",
        "model": "CD100M",
        "firmwareVersion": "1.2.3"
      }
    },
    {
      "alarmId": "alarm-002", 
      "alarmType": "COMMUNICATION_FAILURE",
      "severity": "MEDIUM",
      "status": "ACTIVE",
      "triggeredAt": "2024-01-01T10:25:30Z",
      "description": "Device communication timeout",
      "lastCommunication": "2024-01-01T10:20:00Z",
      "deviceInfo": {
        "serialNumber": "SN123456",
        "model": "CD100M",
        "firmwareVersion": "1.2.3"
      }
    }
  ]
}
```

## Response
### Success Response (201 Created)
```json
{
  "batchId": "batch-alarms-20240101-001",
  "status": "PROCESSED",
  "recordsProcessed": 2,
  "recordsAccepted": 2,
  "recordsRejected": 0,
  "processedAt": "2024-01-01T10:30:05Z"
}
```

### Partial Success Response (202 Accepted)
```json
{
  "batchId": "batch-alarms-20240101-001", 
  "status": "PARTIALLY_PROCESSED",
  "recordsProcessed": 2,
  "recordsAccepted": 1,
  "recordsRejected": 1,
  "processedAt": "2024-01-01T10:30:05Z",
  "errors": [
    {
      "alarmId": "alarm-002",
      "error": "INVALID_SEVERITY",
      "message": "Severity value 'EXTREME' is not valid"
    }
  ]
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Posts alarm data from ORBCOMM satellite communications

### Python Library Usage (vig_orbcomm)
From `vig_orbcomm/vig_library/xcloud.py`:
```python
"v2_post_alarms": {
    "path": "/xcloud/v2/eventstore/data/parsed/alarms",
    "verb": "POST",
    "md5": True
}
```

### Data Flow
1. **ORBCOMM Satellite**: Receives alarm data from remote devices via satellite
2. **vig_orbcomm Service**: Processes and formats alarm data
3. **XCloud v2**: Receives structured alarm data via this endpoint
4. **Event Processing**: Distributes alarms to subscribed services
5. **Notification Services**: Trigger alerts and notifications

### Enhanced v2 Features
- **Structured Data**: Better organized alarm information
- **Metadata Support**: Additional device and location context
- **Batch Processing**: Multiple alarms in single request
- **Error Handling**: Detailed processing feedback
- **Data Validation**: Enhanced validation and error reporting

## Alarm Types
Common alarm types supported:
- **HIGH_LEVEL**: Water or fluid level alarms
- **LOW_LEVEL**: Minimum level warnings
- **PRESSURE_HIGH**: Pressure threshold alarms
- **PRESSURE_LOW**: Low pressure warnings
- **COMMUNICATION_FAILURE**: Device connectivity issues
- **POWER_LOW**: Battery or power supply warnings
- **SENSOR_FAULT**: Sensor malfunction alerts
- **MAINTENANCE_DUE**: Scheduled maintenance reminders

## Severity Levels
- **LOW**: Informational alerts
- **MEDIUM**: Warning conditions
- **HIGH**: Critical issues requiring attention
- **CRITICAL**: Emergency conditions requiring immediate response

## Data Validation
- **Required Fields**: alarmId, alarmType, severity, status, triggeredAt
- **Format Validation**: ISO 8601 timestamps, valid enum values
- **Range Validation**: Threshold and measurement values
- **Device Validation**: Valid device and customer IDs

## Related Endpoints
- [POST /xcloud/v1/eventstore/data/parsed](v1-eventstore-data-parsed-post.md) - Legacy parsed data endpoint
- [POST /xcloud/v2/eventstore/data/parsed/observations](v2-eventstore-data-parsed-observations-post.md) - Post observations
- [POST /xcloud/v2/eventstore/data/parsed/things](v2-eventstore-data-parsed-things-post.md) - Post things
- [POST /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-post.md) - Subscribe to alarm events