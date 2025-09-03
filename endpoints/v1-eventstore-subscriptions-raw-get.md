# GET /xcloud/v1/eventstore/subscriptions/raw

## Overview
Retrieves all raw event data subscriptions for the authenticated service. Returns a list of active subscriptions with their configuration details.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/raw`
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
    "subscriptionId": "sub-raw-12345",
    "subscriberServiceID": "remote-control-service",
    "status": "ACTIVE",
    "createdAt": "2024-01-01T00:00:00Z",
    "callBackConnection": {
      "connectionType": "REST",
      "connectionDetails": {
        "uri": "https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/rawdata"
      }
    },
    "filter": {
      "filterType": "ATTRIBUTE",
      "attributeFilter": {
        "filterName": "vigDps",
        "attributeName": "transportType",
        "attributeValues": ["vigTpsLegacy", "vigTpsQ4000"]
      }
    }
  },
  {
    "subscriptionId": "sub-raw-67890",
    "subscriberServiceID": "device-monitor",
    "status": "ACTIVE", 
    "createdAt": "2024-01-01T12:00:00Z",
    "callBackConnection": {
      "connectionType": "REST",
      "connectionDetails": {
        "uri": "https://monitoring.example.com/webhook/raw"
      }
    },
    "filter": {
      "filterType": "DEVICE",
      "deviceFilter": {
        "deviceIds": ["FST123456789", "FST987654321"]
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
- **vig_orbcomm**: Lists raw data subscriptions for management and monitoring
- **vig_package**: Subscription management utilities

### Python Library Usage (vig_orbcomm/vig_package)
From `vig_orbcomm/vig_library/xcloud.py` and `vig_package/xcloud.py`:
```python
"get_subs_raw": {
    "path": "/xcloud/v1/eventstore/subscriptions/raw",
    "verb": "GET",
    "md5": False
}
```

### Use Cases
- **Subscription Management**: List all active raw subscriptions to monitor system state
- **Health Monitoring**: Verify subscriptions are active and properly configured
- **Cleanup Operations**: Identify unused or stale subscriptions for deletion
- **Configuration Audit**: Review current subscription settings across services

## Response Fields
- **subscriptionId**: Unique identifier for the subscription
- **subscriberServiceID**: Service that created the subscription
- **status**: Current status (ACTIVE, INACTIVE, ERROR)
- **createdAt**: Timestamp when subscription was created
- **callBackConnection**: Webhook endpoint configuration
- **filter**: Criteria for filtering raw events

## Related Endpoints
- [POST /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-post.md) - Create raw subscription
- [GET /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}](v1-eventstore-subscriptions-raw-id-get.md) - Get specific raw subscription
- [DELETE /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}](v1-eventstore-subscriptions-raw-id-delete.md) - Delete raw subscription
- [GET /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-get.md) - List parsed subscriptions