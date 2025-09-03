# POST /xcloud/v1/eventstore/subscriptions/parsed

## Overview
Creates a subscription for parsed event data from XCloud. When events matching the filter criteria occur, XCloud will POST the data to the specified webhook callback URL.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/parsed`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Request Body Structure
```json
{
  "subscriberServiceID": "string",
  "callBackConnection": {
    "connectionType": "REST",
    "connectionDetails": {
      "uri": "string"
    }
  },
  "filter": {
    "filterType": "ATTRIBUTE",
    "attributeFilter": {
      "filterName": "string",
      "attributeName": "string",
      "attributeValues": ["string"]
    }
  }
}
```

## Response
### Success Response (200 OK)
```json
{
  "subscriptionId": "string",
  "status": "ACTIVE",
  "createdAt": "2024-01-01T00:00:00Z",
  "webhookUrl": "string"
}
```

## Production Instances

### fst_remote_control Service

#### Command Status Subscription
**Implementation:** [`fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java:subscribeToCommandStatusData()`](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java)
- **Callback URL:** `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/commandstatus`
- **Controller:** [`fst_remote_control/src/main/java/com/xylem/dewatering/rcs/controller/IncomingSubscriptionDataController.java:receiveCommandStatusFromXCloudSubscription()`](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/controller/IncomingSubscriptionDataController.java)
- **Filter:** 
  - `attributeName`: `transportType`
  - `attributeValues`: `["xylemFstQ4000CommandStatus"]`
  - `filterName`: `fstQ4000CommandStatusFilter`
  - `filterType`: `ATTRIBUTE`

#### Alarms Subscription  
**Implementation:** [`fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java:subscribeToAlarmsData()`](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java)
- **Callback URL:** `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/alarms`
- **Filter:**
  - `attributeName`: `payload.batchType`
  - `attributeValues`: `["ALARMS"]`
  - `filterName`: `fstQ4000AlarmsFilter`
  - `filterType`: `ATTRIBUTE`

### fst_alarm Service

#### Device Observations Subscription
**Implementation:** [`fst_alarm/src/main/java/com/xylem/dewatering/alarm/service/impl/DeviceSubscriptionServiceImpl.java:saveXcloudDeviceSubscription()`](../fst_alarm/src/main/java/com/xylem/dewatering/alarm/service/impl/DeviceSubscriptionServiceImpl.java)
- **Callback URL:** `https://cloud.xylem.com/fst/api/alarm-service/alarm/flowRate`
- **Controller:** [`fst_alarm/src/main/java/com/xylem/dewatering/alarm/controller/AlarmController.java:saveObservationResults()`](../fst_alarm/src/main/java/com/xylem/dewatering/alarm/controller/AlarmController.java)
- **Filter:** Device observation data processing

#### Device Observations V2 Subscription
**Implementation:** [`fst_alarm/src/main/java/com/xylem/dewatering/alarm/service/impl/DeviceSubscriptionServiceImplV2.java`](../fst_alarm/src/main/java/com/xylem/dewatering/alarm/service/impl/DeviceSubscriptionServiceImplV2.java)
- **Callback URL:** `https://cloud.xylem.com/fst/api/alarm-service/alarm/flowRate/v2`
- **Controller:** [`fst_alarm/src/main/java/com/xylem/dewatering/alarm/controller/AlarmController.java:saveObservationResultsV2()`](../fst_alarm/src/main/java/com/xylem/dewatering/alarm/controller/AlarmController.java)
- **Filter:** Enhanced device observation data processing

## QA/Staging Instances

### fst_remote_control Service (QA)

#### Command Status Subscription (QA)
- **Callback URL:** `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/remote-control-service/incomingsubdata/commandstatus`
- **XCloud Host:** `xc-gc-api-gateway.xylem-cloud.com`

#### Alarms Subscription (QA)
- **Callback URL:** `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/remote-control-service/incomingsubdata/alarms`
- **XCloud Host:** `xc-gc-api-gateway.xylem-cloud.com`

### fst_alarm Service (QA)
- **Callback URL:** `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/alarm-service/alarm/flowRate`
- **XCloud Host:** `xc-gc-api-gateway.xylem-cloud.com`

## Test/Development Instances

### fst_remote_control Service (Dev)

#### Command Status Subscription (Dev)
- **Callback URL:** `https://18.221.161.197:8099/ws/api/remote-control-service/incomingsubdata/commandstatus`
- **XCloud Host:** `xc-gcdev-api-gateway.xylem-cloud.com`
- **Configuration:** `config-repo/remote-control-service-dev.properties:parsedSubCommandCallbackURL`

#### Alarms Subscription (Dev)
- **Callback URL:** `https://cloudfront-gc.xylem-cloud.com/dev-fst/api/remote-control-service/incomingsubdata/alarms`
- **Configuration:** `config-repo/remote-control-service-dev.properties:parsedSubAlarmsCallbackURL`

### fst_alarm Service (Test)

#### Test Alarm Subscription
**Implementation:** [`fst_alarm/src/test/java/com/xylem/dewatering/alarm/SubscriptionTest.java:testSubscriptionForAlarm()`](../fst_alarm/src/test/java/com/xylem/dewatering/alarm/SubscriptionTest.java)
- **Callback URL:** `http://ec2-18-221-161-197.us-east-2.compute.amazonaws.com:8095/alarm/saveAlarm`
- **XCloud Host:** `gc-xc-api-gateway.xylem-cloud.com`
- **Filter:**
  - `attributeName`: `payload.batchType`
  - `attributeValues`: `["ALARMS"]`
  - `filterName`: `AlarmFilter`
  - `filterType`: `ATTRIBUTE`

### Location Service (Test)
**Implementation:** [`fst_location/src/test/java/com/xylem/dewatering/lms/XCloudTest.java`](../fst_location/src/test/java/com/xylem/dewatering/lms/XCloudTest.java)
- Test subscription setup for location-based services

## Common Filter Types

### Attribute Filters
- `payload.batchType`: `["ALARMS", "COMMANDSTATUS", "OBSERVATIONS"]`
- `transportType`: `["xylemFstQ4000CommandStatus"]`

### Filter Names
- `fstQ4000CommandStatusFilter` - Command status events
- `fstQ4000AlarmsFilter` - Alarm events  
- `AlarmFilter` - Generic alarm filter (test)

## Webhook Security
All webhook callbacks include HMAC-SHA256 authentication:
- **Authorization** header with signature
- **Date** header with timestamp
- Receiving service validates signature using shared secret

## Environment Configuration

### Production
- **XCloud Host:** `cloud.xylem.com`
- **Service Base:** `https://cloud.xylem.com/fst/api/`

### QA
- **XCloud Host:** `xc-gc-api-gateway.xylem-cloud.com`
- **Service Base:** `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/`

### Development
- **XCloud Host:** `xc-gcdev-api-gateway.xylem-cloud.com`
- **Service Base:** Various (IP-based and cloudfront domains)

## Related Endpoints
- [GET /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-get.md) - List subscriptions
- [DELETE /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}](v1-eventstore-subscriptions-parsed-id-delete.md) - Delete subscription
- [POST /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-post.md) - Subscribe to raw data