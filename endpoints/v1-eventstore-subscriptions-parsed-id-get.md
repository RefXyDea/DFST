# GET /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}

## Overview
Retrieves a specific parsed event data subscription by its unique subscription ID. Returns detailed configuration and status information for the subscription.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required

## Path Parameters
- **subscriptionId** (string, required): The unique identifier of the subscription to retrieve

## Response
### Success Response (200 OK)
```json
{
  "subscriptionId": "sub-parsed-12345",
  "subscriberServiceID": "remote-control-service",
  "status": "ACTIVE",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-02T10:30:00Z",
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
  },
  "statistics": {
    "eventsDelivered": 2847,
    "lastEventDelivered": "2024-01-02T10:29:45Z",
    "failedDeliveries": 1,
    "lastFailureReason": null
  }
}
```

### Not Found Response (404 Not Found)
```json
{
  "error": "SUBSCRIPTION_NOT_FOUND",
  "message": "Subscription with ID 'sub-parsed-12345' not found or access denied",
  "subscriptionId": "sub-parsed-12345"
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Retrieves specific parsed subscription details for monitoring
- **vig_package**: Subscription management utilities
- **fst_alarm**: Monitors alarm subscription health

### Python Library Usage (vig_orbcomm/vig_package)
From `vig_orbcomm/vig_library/xcloud.py` and `vig_package/xcloud.py`:
```python
"get_sub_parsed": {
    "path": "/xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}",
    "verb": "GET",
    "md5": False
}
```

### Use Cases
- **Subscription Monitoring**: Check the health and status of a specific parsed subscription
- **Configuration Verification**: Confirm subscription settings match expected values
- **Troubleshooting**: Investigate delivery issues or subscription problems
- **Analytics**: Retrieve statistics on subscription performance

### Common Subscription Examples

#### Command Status Subscription
- **Webhook**: `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/commandstatus`
- **Filter**: `payload.batchType = ["COMMANDSTATUS"]`
- **Purpose**: Receive device command execution status updates

#### Alarm Subscription
- **Webhook**: `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/alarms`
- **Filter**: `payload.batchType = ["ALARMS"]`  
- **Purpose**: Receive alarm notifications for devices

#### Test Alarm Subscription (Development)
- **Webhook**: `http://ec2-18-221-161-197.us-east-2.compute.amazonaws.com:8095/alarm/saveAlarm`
- **Filter**: Custom alarm filters
- **Purpose**: Development and testing of alarm processing

## Response Fields
- **subscriptionId**: Unique identifier for the subscription
- **subscriberServiceID**: Service that owns the subscription
- **status**: Current subscription status (ACTIVE, INACTIVE, ERROR, SUSPENDED)
- **createdAt**: Timestamp when subscription was created
- **updatedAt**: Timestamp when subscription was last modified
- **callBackConnection**: Webhook endpoint configuration
- **filter**: Criteria for filtering parsed events
- **statistics**: Performance and delivery metrics (when available)

## Error Codes
- **404**: Subscription not found or access denied
- **401**: Authentication required
- **403**: Insufficient permissions to access subscription
- **500**: Internal server error

## Related Endpoints
- [POST /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-post.md) - Create parsed subscription
- [GET /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-get.md) - List all parsed subscriptions
- [DELETE /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}](v1-eventstore-subscriptions-parsed-id-delete.md) - Delete parsed subscription
- [GET /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}](v1-eventstore-subscriptions-raw-id-get.md) - Get specific raw subscription