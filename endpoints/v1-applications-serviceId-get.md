# GET /xcloud/v1/applications/{serviceId}

## Overview
Retrieves details of a specific application by its service ID.

## Endpoint Details
- **Path**: `/xcloud/v1/applications/{serviceId}`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **serviceId**: The unique identifier of the application

## Response
### Success Response (200 OK)
```json
{
  "serviceId": "string",
  "applicationName": "string",
  "description": "string",
  "permissions": ["READ", "WRITE"],
  "endpoints": [],
  "status": "ACTIVE",
  "createdAt": "2024-01-01T00:00:00Z",
  "lastModified": "2024-01-01T00:00:00Z"
}
```

### Error Response (404 Not Found)
```json
{
  "error": "Application not found",
  "serviceId": "string"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Get specific application configuration
- **vig_package**: Application lookup

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_app": {"path":"/xcloud/v1/applications/{serviceId}", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/applications](v1-applications-get.md) - List all applications
- [PATCH /xcloud/v1/applications/{serviceId}](v1-applications-serviceId-patch.md) - Update application
- [DELETE /xcloud/v1/applications/{serviceId}](v1-applications-serviceId-delete.md) - Delete application