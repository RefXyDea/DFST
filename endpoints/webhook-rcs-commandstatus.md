# Webhook: /incomingsubdata/commandstatus

## Overview
Receives command status updates from XCloud via webhook callbacks. This endpoint is registered as a callback URL when creating parsed data subscriptions.

## Endpoint Details
- **Path**: `/incomingsubdata/commandstatus`
- **Method**: POST (called by XCloud)
- **Content-Type**: application/json
- **Authentication**: HMAC-SHA256 signature validation required

## Environment URLs

| Environment | Full Webhook URL |
|-------------|------------------|
| Production | `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/commandstatus` |
| QA | `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/remote-control-service/incomingsubdata/commandstatus` |
| Dev | `https://18.221.161.197:8099/ws/api/remote-control-service/incomingsubdata/commandstatus` |
| Local | `https://localhost:8099/ws/api/remote-control-service/incomingsubdata/commandstatus` |

## Webhook Payload (Received from XCloud)
```json
{
  "deviceType": "xylemFst",
  "deviceID": "FST300234030000001",
  "payload": {
    "batchType": "COMMANDSTATUS",
    "commandId": "cmd-12345",
    "status": "SUCCESS",
    "result": "Command executed successfully",
    "timestamp": "2024-01-01T12:00:00Z",
    "deviceResponse": {
      "pumpStatus": "RUNNING",
      "flow": 25.6,
      "pressure": 15.2
    }
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Implementation

### Controller Handler
From `fst_remote_control/src/main/java/com/xylem/dewatering/rcs/controller/IncomingSubscriptionDataController.java:47`:

```java
@PostMapping(value = "/commandstatus", produces = "application/json", consumes = "application/json")
public ResponseEntity<String> receiveCommandStatusFromXCloudSubscription(
        @RequestHeader String authorization,
        @RequestHeader String date,
        @RequestBody XCloudIncomingCommandStatusDataDto incomingData) throws BaseException {
    
    if (ClientReceivingFromXCloudAuthUtil.confirmAuthHeader(
            secretKeysProperties.getAuthServiceId(), 
            secretKeysProperties.getSecreteKey(), 
            authorization, 
            date)) {
        
        commandService.updateCommandStatus(incomingData);
        return new ResponseEntity<>("OK", HttpStatus.OK);
    }
    
    return new ResponseEntity<>("Unauthorized command", HttpStatus.UNAUTHORIZED);
}
```

### Registration Configuration
From configuration files:
```yaml
# Production
parsedSubCommandCallbackURL: https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/commandstatus
parsedSubCommandCallbackPath: /incomingsubdata/commandstatus
```

### Subscription Filter
The webhook is registered with this filter:
```json
{
  "filterType": "ATTRIBUTE",
  "attributeFilter": {
    "attributeName": "payload.batchType",
    "attributeValues": ["COMMANDSTATUS"]
  }
}
```

## Security
- HMAC-SHA256 signature validation using shared secret
- Date header validation to prevent replay attacks
- Authorization header format: `HMAC-SHA256 signature`

## Related Webhooks
- [/incomingsubdata/alarms](webhook-rcs-alarms.md) - Alarm notifications webhook
- [/alarm/saveAlarm](webhook-alarm-saveAlarm.md) - Alarm service webhook