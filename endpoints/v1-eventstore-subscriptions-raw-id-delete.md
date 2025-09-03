# DELETE /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}

## Overview
Deletes a specific raw event data subscription by its unique subscription ID. Once deleted, the subscription will stop receiving raw events and cannot be recovered.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}`
- **Method**: DELETE
- **Content-Type**: application/json
- **Authentication**: Required

## Path Parameters
- **subscriptionId** (string, required): The unique identifier of the subscription to delete

## Response
### Success Response (200 OK)
```json
{
  "subscriptionId": "sub-raw-12345",
  "status": "DELETED",
  "deletedAt": "2024-01-01T12:30:00Z",
  "message": "Raw subscription successfully deleted"
}
```

### No Content Response (204 No Content)
Empty response body - deletion was successful.

### Not Found Response (404 Not Found)
```json
{
  "error": "SUBSCRIPTION_NOT_FOUND",
  "message": "Subscription with ID 'sub-raw-12345' not found or already deleted",
  "subscriptionId": "sub-raw-12345"
}
```

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Deletes obsolete or misconfigured raw subscriptions
- **vig_package**: Subscription management utilities

### Python Library Usage (vig_orbcomm/vig_package)
From `vig_orbcomm/vig_library/xcloud.py` and `vig_package/xcloud.py`:
```python
"delete_sub_raw": {
    "path": "/xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}",
    "verb": "DELETE",
    "md5": False
}
```

### Use Cases
- **Subscription Cleanup**: Remove unused or outdated raw subscriptions
- **Service Decommissioning**: Clean up subscriptions when services are removed
- **Configuration Changes**: Delete old subscriptions before creating new ones with updated settings
- **Error Recovery**: Remove problematic subscriptions that are causing delivery issues

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

## Related Endpoints
- [POST /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-post.md) - Create raw subscription
- [GET /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-get.md) - List all raw subscriptions
- [GET /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}](v1-eventstore-subscriptions-raw-id-get.md) - Get specific raw subscription
- [DELETE /xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}](v1-eventstore-subscriptions-parsed-id-delete.md) - Delete parsed subscription