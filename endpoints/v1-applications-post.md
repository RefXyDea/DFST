# POST /xcloud/v1/applications

## Overview
Registers a new application with XCloud for accessing IoT services.

## Endpoint Details
- **Path**: `/xcloud/v1/applications`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Optional (auth:false in configuration)

## Request Body
```json
{
  "serviceId": "string",
  "applicationName": "string",
  "description": "string",
  "permissions": ["READ", "WRITE"],
  "endpoints": []
}
```

## Response
### Success Response (200 OK)
```json
{
  "serviceId": "string",
  "applicationName": "string",
  "status": "REGISTERED",
  "apiKey": "string",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Registers applications for satellite data processing
- **vig_package**: Application registration utilities

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "register_app": {"path":"/xcloud/v1/applications", "verb":"POST", "md5":False, "auth":False}
}
```

## Related Endpoints
- [GET /xcloud/v1/applications](v1-applications-get.md) - List all applications
- [PATCH /xcloud/v1/applications/{serviceId}](v1-applications-serviceId-patch.md) - Update application