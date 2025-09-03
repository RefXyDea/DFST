# GET /xcloud/v1/users

## Overview
Retrieves users with pagination support. Used primarily in test environments for user management verification.

## Endpoint Details
- **Path**: `/xcloud/v1/users`
- **Method**: GET
- **Content-Type**: application/json
- **Authentication**: Required

## Query Parameters
- **page** (integer): Page number for pagination
- **size** (integer): Number of users per page

## Response
### Success Response (200 OK)
```json
{
  "content": [
    {
      "userId": "user-001",
      "username": "john.doe",
      "email": "john.doe@example.com",
      "firstName": "John",
      "lastName": "Doe",
      "status": "ACTIVE",
      "customerId": "FST-customer-001"
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 20,
    "totalElements": 50,
    "totalPages": 3
  }
}
```

## Usage in Codebase
- **fst_user-service (test)**: User management testing
- **fst_location (test)**: Location service user validation

## Related Endpoints
- [GET /xcloud/v1/users/{userId}](v1-users-userId-get.md) - Get specific user
- [GET /xcloud/v1/users?page={page}&size={size}](v1-users-paginated-get.md) - Paginated users
