# DELETE /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}

## Overview
Deletes a specific parsed event data subscription by its unique subscription ID. Once deleted, the subscription will stop receiving parsed events and cannot be recovered.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}`
- **Method**: DELETE
- **Content-Type**: application/json
- **Authentication**: Required

## Path Parameters
- **subscriptionId** (string, required): The unique identifier of the subscription to delete

## Response
### Success Response (200 OK)
```json
{
  "subscriptionId": "sub-parsed-12345",
  "status": "DELETED",
  "deletedAt": "2024-01-01T12:30:00Z",
  "message": "Parsed subscription successfully deleted"
}
```

### No Content Response (204 No Content)
Empty response body - deletion was successful.

### Not Found Response (404 Not Found)
```json
{
  "error": "SUBSCRIPTION_NOT_FOUND",
  "message": "Subscription with ID 'sub-parsed-12345' not found or already deleted",
  "subscriptionId": "sub-parsed-12345"
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Deletes obsolete or misconfigured parsed subscriptions
- **vig_package**: Subscription management utilities
- **fst_alarm**: Manages alarm subscription lifecycle

### Python Library Usage (vig_orbcomm/vig_package)
From `vig_orbcomm/vig_library/xcloud.py` and `vig_package/xcloud.py`:
```python
"delete_sub_parsed": {
    "path": "/xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}",
    "verb": "DELETE",
    "md5": False
}
```

### Use Cases
- **Subscription Cleanup**: Remove unused or outdated parsed subscriptions
- **Service Decommissioning**: Clean up subscriptions when services are removed
- **Configuration Changes**: Delete old subscriptions before creating new ones with updated settings
- **Error Recovery**: Remove problematic subscriptions that are causing delivery issues

### Common Deletion Scenarios

#### Command Status Subscriptions
- Delete when remote control service is reconfigured
- Remove during service maintenance or updates
- Clean up when webhook URLs change

#### Alarm Subscriptions
- Remove when alarm processing logic changes
- Delete test subscriptions after development
- Clean up when moving between environments

#### Development/Test Cleanup
- Remove test subscriptions like:
  - `http://ec2-18-221-161-197.us-east-2.compute.amazonaws.com:8095/alarm/saveAlarm`
- Clean up after integration testing

## Important Notes
- **Permanent Deletion**: Once deleted, subscriptions cannot be recovered
- **Immediate Effect**: Event delivery stops immediately upon deletion
- **Webhook Cleanup**: Consider cleaning up webhook endpoints after deletion
- **Audit Trail**: Keep records of deleted subscriptions for compliance

## Response Behaviors
- **200 OK**: Standard success response with deletion details
- **204 No Content**: Alternative success response with no body
- **404 Not Found**: Subscription doesn't exist or was already deleted
- **403 Forbidden**: Insufficient permissions to delete the subscription
- **401 Unauthorized**: Authentication required

## Best Practices
1. **Verify Before Deletion**: Use GET endpoint to confirm subscription details before deleting
2. **Graceful Shutdown**: Stop dependent processes before deleting subscriptions
3. **Monitoring**: Monitor webhook endpoints for unexpected traffic after deletion
4. **Documentation**: Log subscription deletions for operational awareness
5. **Environment Awareness**: Be careful when deleting subscriptions in production environments

## Related Endpoints
- [POST /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-post.md) - Create parsed subscription
- [GET /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-get.md) - List all parsed subscriptions
- [GET /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}](v1-eventstore-subscriptions-parsed-id-get.md) - Get specific parsed subscription
- [DELETE /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}](v1-eventstore-subscriptions-raw-id-delete.md) - Delete raw subscription