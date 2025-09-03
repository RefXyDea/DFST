# DELETE /xcloud/v1/applications/{serviceId}

## Overview
Deletes a registered application from XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/applications/{serviceId}`
- **Method**: DELETE
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **serviceId**: The unique identifier of the application to delete

## Response
### Success Response (200 OK)
```json
{
  "message": "Application deleted successfully",
  "serviceId": "string"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Application not found",
  "serviceId": "string"
}
```

### Error Response (409 Conflict)
```json
{
  "error": "Cannot delete application with active sessions",
  "activeSessions": 3
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Cleanup applications
- **vig_package**: Application management

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "delete_app": {"path":"/xcloud/v1/applications/{serviceId}", "verb":"DELETE", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/applications](v1-applications-get.md) - List all applications
- [GET /xcloud/v1/applications/{serviceId}](v1-applications-serviceId-get.md) - Get application details