# GET /xcloud/v1/applications

## Overview
Retrieves a list of all registered applications from XCloud.

## Endpoint Details
- **Path**: `/xcloud/v1/applications`
- **Method**: GET
- **Authentication**: Required (HMAC-SHA256)

## Query Parameters
- **page** (optional): Page number for pagination
- **size** (optional): Number of items per page

## Response
### Success Response (200 OK)
```json
{
  "applications": [
    {
      "serviceId": "string",
      "applicationName": "string",
      "description": "string",
      "permissions": ["READ", "WRITE"],
      "status": "ACTIVE",
      "createdAt": "2024-01-01T00:00:00Z"
    }
  ],
  "totalCount": 5,
  "page": 0,
  "size": 20
}
```

## Usage in Codebase

### VIG Services
- **vig_orbcomm**: Lists available applications
- **vig_package**: Application discovery

### Python Example (vig_orbcomm)
```python
# From vig_orbcomm/vig_library/xcloud.py
endpoints = {
    "get_app_all": {"path":"/xcloud/v1/applications", "verb":"GET", "md5":False}
}
```

## Related Endpoints
- [POST /xcloud/v1/applications](v1-applications-post.md) - Register new application
- [GET /xcloud/v1/applications/{serviceId}](v1-applications-serviceId-get.md) - Get specific application