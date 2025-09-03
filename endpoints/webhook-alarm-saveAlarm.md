# POST /alarm/saveAlarm

## Overview
Webhook endpoint that receives and processes alarm data from XCloud event subscriptions. This endpoint is registered as a callback URL in XCloud parsed event subscriptions and receives alarm notifications for processing by the FST alarm service.

## Endpoint Details
- **Path**: `/alarm/saveAlarm`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: HMAC-SHA256 (webhook signature validation)
- **Service**: fst_alarm

## Registered Webhook URLs

### Test Environment (Development)
- `http://ec2-18-221-161-197.us-east-2.compute.amazonaws.com:8095/alarm/saveAlarm`
- `http://localhost:8095/alarm/saveAlarm` (local testing)

## Request Body
Incoming alarm data from XCloud subscription:
```json
{
  "batchId": "batch-alarms-20240101-001",
  "timestamp": "2024-01-01T10:30:00Z",
  "deviceId": "FST123456789",
  "customerId": "customer-001",
  "payload": {
    "batchType": "ALARMS",
    "alarmId": "alarm-001",
    "alarmType": "HIGH_LEVEL",
    "severity": "HIGH",
    "status": "ACTIVE",
    "triggeredAt": "2024-01-01T10:29:45Z",
    "description": "Water level above threshold",
    "thresholdValue": 85.0,
    "currentValue": 92.3,
    "unit": "percent",
    "deviceInfo": {
      "serialNumber": "SN123456",
      "model": "CD100M",
      "firmwareVersion": "1.2.3"
    }
  }
}
```

## Response
### Success Response (200 OK)
```json
{
  "status": "PROCESSED",
  "alarmId": "alarm-001",
  "processedAt": "2024-01-01T10:30:05Z",
  "actions": [
    "NOTIFICATION_SENT",
    "DATABASE_UPDATED",
    "HISTORY_LOGGED"
  ]
}
```

### Error Response (400 Bad Request)
```json
{
  "error": "INVALID_ALARM_DATA",
  "message": "Missing required field: alarmType",
  "timestamp": "2024-01-01T10:30:05Z"
}
```

## Usage in Codebase

### FST Alarm Service Implementation
The endpoint is implemented in the FST alarm service:

#### Service Interface
From `fst_alarm/src/main/java/com/xylem/dewatering/alarm/service/AlarmService.java`:
```java
Boolean saveAlarm(AlarmDto alarmDto) throws HttpException, JsonProcessingException, BaseException;
```

#### Implementation Classes
- **AlarmServiceImpl**: Main implementation for alarm processing
- **AlarmServiceImplV2**: Enhanced version with additional features
- **SaveAlarmSQSConsumer**: SQS-based alarm processing consumer

### Alarm Processing Features

#### Controller Alarm Types
The service processes various alarm types:
- **HIGH_SOOT_LEVEL**: Engine soot level alarms
- **LOW_DEF_LEVEL**: Diesel exhaust fluid level warnings
- **LOW_SUCTION_PRESSURE**: Suction pressure alarms
- **HIGH_SUCTION_PRESSURE**: High suction pressure warnings
- **LOW_DISCHARGE_PRESSURE**: Discharge pressure alarms
- **HIGH_DISCHARGE_PRESSURE**: High discharge pressure warnings
- **LOW_FLOW**: Flow rate below threshold
- **HIGH_FLOW**: Flow rate above threshold
- **LOW_SUMP_LEVEL**: Sump level warnings
- **HIGH_SUMP_LEVEL**: High sump level alarms
- **LOW_FUEL_LEVEL**: Fuel level warnings
- **KEYSWITCH**: Keyswitch position alarms
- **GEO_FENCE**: Geofence boundary violations

#### Processing Operations
1. **Validation**: Validate incoming alarm data structure
2. **Database Storage**: Save alarm to subscription alarm tables
3. **History Logging**: Create alarm history records
4. **Notification**: Trigger notifications based on severity
5. **SQS Integration**: Queue alarms for asynchronous processing

### Test Configuration
From `fst_alarm/src/test/java/com/xylem/dewatering/alarm/SubscriptionTest.java`:
```java
"uri": "http://ec2-18-221-161-197.us-east-2.compute.amazonaws.com:8095/alarm/saveAlarm"
```

## Webhook Registration
This endpoint is registered as a callback URL when creating XCloud parsed event subscriptions:

```json
{
  "callBackConnection": {
    "connectionType": "REST",
    "connectionDetails": {
      "uri": "http://ec2-18-221-161-197.us-east-2.compute.amazonaws.com:8095/alarm/saveAlarm"
    }
  },
  "filter": {
    "filterType": "ATTRIBUTE",
    "attributeFilter": {
      "attributeName": "payload.batchType",
      "attributeValues": ["ALARMS"]
    }
  }
}
```

## Security
- **HMAC Validation**: Validates webhook signature from XCloud
- **Content Verification**: Validates alarm data structure and required fields
- **Error Handling**: Comprehensive error handling for malformed data

## Related Endpoints
- [POST /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-post.md) - Create subscription to register this webhook
- [POST /xcloud/v2/eventstore/data/parsed/alarms](v2-eventstore-data-parsed-alarms-post.md) - Post alarms to XCloud
- [/incomingsubdata/alarms](webhook-rcs-alarms.md) - Remote control service alarm webhook
- [/incomingsubdata/commandstatus](webhook-rcs-commandstatus.md) - Command status webhook