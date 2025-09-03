# GET /xcloud/v1/eventstore/subscriptions/parsed

## Overview
Retrieves all parsed event data subscriptions for the authenticated service. Returns a list of active subscriptions with their configuration details.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/parsed`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required

## Request Parameters
None required - returns all subscriptions for the authenticated service.

## Response
### Success Response (200 OK)
```json
[
  {
    "subscriptionId": "sub-parsed-12345",
    "subscriberServiceID": "remote-control-service",
    "status": "ACTIVE",
    "createdAt": "2024-01-01T00:00:00Z",
    "callBackConnection": {
      "connectionType": "REST",
      "connectionDetails": {
        "uri": "https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/commandstatus"
      }
    },
    "filter": {
      "filterType": "ATTRIBUTE",
      "attributeFilter": {
        "filterName": "CommandStatusFilter",
        "attributeName": "payload.batchType",
        "attributeValues": ["COMMANDSTATUS"]
      }
    }
  },
  {
    "subscriptionId": "sub-parsed-67890",
    "subscriberServiceID": "alarm-service",
    "status": "ACTIVE",
    "createdAt": "2024-01-01T12:00:00Z",
    "callBackConnection": {
      "connectionType": "REST",
      "connectionDetails": {
        "uri": "http://ec2-18-221-161-197.us-east-2.compute.amazonaws.com:8095/alarm/saveAlarm"
      }
    },
    "filter": {
      "filterType": "ATTRIBUTE",
      "attributeFilter": {
        "filterName": "AlarmFilter",
        "attributeName": "payload.batchType",
        "attributeValues": ["ALARMS"]
      }
    }
  }
]
```

### Empty Response (200 OK)
```json
[]
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Lists parsed data subscriptions for management and monitoring
- **vig_package**: Subscription management utilities
- **fst_alarm**: Manages alarm-related subscriptions

### Python Library Usage (vig_orbcomm/vig_package)
From `vig_orbcomm/vig_library/xcloud.py` and `vig_package/xcloud.py`:
```python
"get_subs_parsed": {
    "path": "/xcloud/v1/eventstore/subscriptions/parsed",
    "verb": "GET",
    "md5": False
}
```

### Use Cases
- **Subscription Management**: List all active parsed subscriptions to monitor system state
- **Health Monitoring**: Verify subscriptions are active and properly configured
- **Cleanup Operations**: Identify unused or stale subscriptions for deletion
- **Configuration Audit**: Review current subscription settings across services

### Common Subscription Types
Based on existing implementations:

#### Command Status Subscriptions
- **Webhook**: `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/commandstatus`
- **Filter**: `payload.batchType = ["COMMANDSTATUS"]`
- **Service**: remote-control-service

#### Alarm Subscriptions  
- **Webhook**: `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/alarms`
- **Filter**: `payload.batchType = ["ALARMS"]`
- **Service**: remote-control-service, alarm-service

#### Observation Subscriptions
- **Filter**: `payload.batchType = ["OBSERVATIONS"]`
- **Service**: Various monitoring services

## Response Fields
- **subscriptionId**: Unique identifier for the subscription
- **subscriberServiceID**: Service that created the subscription
- **status**: Current status (ACTIVE, INACTIVE, ERROR)
- **createdAt**: Timestamp when subscription was created
- **callBackConnection**: Webhook endpoint configuration
- **filter**: Criteria for filtering parsed events

## Related Endpoints
- [POST /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-post.md) - Create parsed subscription
- [GET /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}](v1-eventstore-subscriptions-parsed-id-get.md) - Get specific parsed subscription
- [DELETE /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}](v1-eventstore-subscriptions-parsed-id-delete.md) - Delete parsed subscription
- [GET /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-get.md) - List raw subscriptions