# PATCH /xcloud/v1/applications/{serviceId}

## Overview
Updates an existing application registration in XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/applications/{serviceId}`
- **Method**: PATCH
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256)

## Path Parameters
- **serviceId**: The unique identifier of the application to update

## Request Body
```json
{
  "applicationName": "string",
  "description": "string",
  "permissions": ["READ", "WRITE", "ADMIN"],
  "endpoints": []
}
```

## Response
### Success Response (200 OK)
```json
{
  "serviceId": "string",
  "applicationName": "string",
  "description": "string",
  "permissions": ["READ", "WRITE", "ADMIN"],
  "status": "ACTIVE",
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
- **vig_orbcomm**: Updates application configuration
- **vig_package**: Application management utilities

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "patch_app": {"path":"/xcloud/v1/applications/{serviceId}", "verb":"PATCH", "md5":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/applications/{serviceId}](v1-applications-serviceId-get.md) - Get application details
- [DELETE /xcloud/v1/applications/{serviceId}](v1-applications-serviceId-delete.md) - Delete application
- [POST /xcloud/v1/applications](v1-applications-post.md) - Register new application