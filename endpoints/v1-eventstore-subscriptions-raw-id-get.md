# GET /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}

## Overview
Retrieves a specific raw event data subscription by its unique subscription ID. Returns detailed configuration and status information for the subscription.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required

## Path Parameters
- **subscriptionId** (string, required): The unique identifier of the subscription to retrieve

## Response
### Success Response (200 OK)
```json
{
  "subscriptionId": "sub-raw-12345",
  "subscriberServiceID": "remote-control-service",
  "status": "ACTIVE",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-02T10:30:00Z",
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
  },
  "statistics": {
    "eventsDelivered": 1250,
    "lastEventDelivered": "2024-01-02T10:29:45Z",
    "failedDeliveries": 3,
    "lastFailureReason": null
  }
}
```

### Not Found Response (404 Not Found)
```json
{
  "error": "SUBSCRIPTION_NOT_FOUND",
  "message": "Subscription with ID 'sub-raw-12345' not found or access denied",
  "subscriptionId": "sub-raw-12345"
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Retrieves specific raw subscription details for monitoring
- **vig_package**: Subscription management utilities

### Python Library Usage (vig_orbcomm/vig_package)
From `vig_orbcomm/vig_library/xcloud.py` and `vig_package/xcloud.py`:
```python
"get_sub_raw": {
    "path": "/xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}",
    "verb": "GET",
    "md5": False
}
```

### Use Cases
- **Subscription Monitoring**: Check the health and status of a specific raw subscription
- **Configuration Verification**: Confirm subscription settings match expected values
- **Troubleshooting**: Investigate delivery issues or subscription problems
- **Analytics**: Retrieve statistics on subscription performance

## Response Fields
- **subscriptionId**: Unique identifier for the subscription
- **subscriberServiceID**: Service that owns the subscription
- **status**: Current subscription status (ACTIVE, INACTIVE, ERROR, SUSPENDED)
- **createdAt**: Timestamp when subscription was created
- **updatedAt**: Timestamp when subscription was last modified
- **callBackConnection**: Webhook endpoint configuration
- **filter**: Criteria for filtering raw events
- **statistics**: Performance and delivery metrics (when available)

## Error Codes
- **404**: Subscription not found or access denied
- **401**: Authentication required
- **403**: Insufficient permissions to access subscription
- **500**: Internal server error

## Related Endpoints
- [POST /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-post.md) - Create raw subscription
- [GET /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-get.md) - List all raw subscriptions
- [DELETE /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}](v1-eventstore-subscriptions-raw-id-delete.md) - Delete raw subscription
- [GET /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}](v1-eventstore-subscriptions-parsed-id-get.md) - Get specific parsed subscription