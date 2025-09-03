# Webhook: /incomingsubdata/alarms

## Overview
Receives alarm notifications from XCloud via webhook callbacks. This endpoint is registered as a callback URL when creating parsed data subscriptions for alarm events.

## Endpoint Details
- **Path**: `/incomingsubdata/alarms`
- **Method**: POST (called by XCloud)
- **Content-Type**: application/json
- **Authentication**: HMAC-SHA256 signature validation required

## Environment URLs

| Environment | Full Webhook URL |
|-------------|------------------|
| Production | `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/alarms` |
| QA | `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/remote-control-service/incomingsubdata/alarms` |
| Dev | `https://cloudfront-gc.xylem-cloud.com/dev-fst/api/remote-control-service/incomingsubdata/alarms` |
| Local | `https://localhost:8099/ws/api/remote-control-service/incomingsubdata/alarms` |

## Webhook Payload (Received from XCloud)
```json
{
  "deviceType": "xylemFst",
  "deviceID": "FST300234030000001",
  "payload": {
    "batchType": "ALARMS",
    "alarms": [
      {
        "alarmCode": "APP001",
        "severity": "HIGH",
        "description": "High pressure detected",
        "timestamp": "2024-01-01T12:00:00Z",
        "value": 45.6,
        "unit": "PSI",
        "thresholds": {
          "warning": 30.0,
          "critical": 40.0
        }
      }
    ]
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Implementation

### Subscription Registration
From `fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java`:

```java
public String generateParsedAlarmsSubscriptionCallbackUri() {
    if (!(StringUtils.isEmpty(properties.getParsedSubAlarmsCallbackURL()))) {
        return properties.getParsedSubAlarmsCallbackURL();
    }
    
    if (properties.getRcsHostName().contains("cloud-xylem.net")) {
        return new StringBuilder(properties.getAppProtocolSecured() + "://")
                .append(properties.getRcsHostName())
                .append("/ws/api/remote-control-service")
                .append(properties.getParsedSubAlarmsCallbackPath())
                .toString();
    }
    // ... environment-specific URL generation
}
```

### Configuration
From configuration files:
```yaml
# Production
parsedSubAlarmsCallbackURL: https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/alarms
parsedSubAlarmsCallbackPath: /incomingsubdata/alarms
```

### Subscription Filter
The webhook is registered with this filter:
```json
{
  "filterType": "ATTRIBUTE", 
  "attributeFilter": {
    "attributeName": "payload.batchType",
    "attributeValues": ["ALARMS"]
  }
}
```

## Processing
When alarms are received:
1. **Authentication**: Validate HMAC signature
2. **Parsing**: Extract alarm data from payload
3. **Processing**: Update alarm status in system
4. **Notification**: Trigger user notifications if configured

## Related Webhooks
- [/incomingsubdata/commandstatus](webhook-rcs-commandstatus.md) - Command status webhook
- [/alarm/saveAlarm](webhook-alarm-saveAlarm.md) - Direct alarm processing webhook