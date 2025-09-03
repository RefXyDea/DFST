# HEAD /xcloud/v1/customers/{customerIds}

## Overview
Checks if one or more customers exist in XCloud without returning the full customer data. Returns HTTP status codes to indicate existence.

## Endpoint Details
- **Path**: `/xcloud/v1/customers/{customerIds}`
- **Method**: HEAD
- **Content-Type**: application/json
- **Authentication**: Required

## Path Parameters
- **customerIds** (string, required): Single customer ID or comma-separated list of customer IDs to check

## Response
### Success Response (200 OK)
Empty response body. Customer(s) exist.

### Not Found Response (404 Not Found)
Empty response body. One or more customers do not exist.

### Partial Success Response (207 Multi-Status)
Empty response body. Some customers exist, others do not (when checking multiple IDs).

## Usage in Codebase

### Production Services
- **vig_orbcomm**: Verifies customer existence before device operations
- **vig_package**: Customer validation utilities

### Python Library Usage (vig_orbcomm/vig_package)
```python
"exists_customer": {
    "path": "/xcloud/v1/customers/{customerIds}",
    "verb": "HEAD",
    "md5": False
}
```

## Usage Examples

### Single Customer Check
```
HEAD /xcloud/v1/customers/FST-1536312680993-Customer1
```

### Multiple Customers Check
```
HEAD /xcloud/v1/customers/FST-1536312680993-Customer1,FST-1536316721808-Customer2,FST-invalid-id
```

## Use Cases
- **Validation**: Verify customer existence before operations
- **Bulk Operations**: Check multiple customers efficiently
- **Performance**: Lightweight existence check without data transfer
- **Integration**: Validate customer IDs during data imports

## Response Interpretation
- **200 OK**: All specified customers exist
- **404 Not Found**: None of the specified customers exist
- **207 Multi-Status**: Mixed results (some exist, some don't)

## Performance Benefits
- **Minimal Data Transfer**: No response body returned
- **Fast Execution**: Optimized for existence checking only
- **Bandwidth Efficient**: Ideal for validation scenarios

## Related Endpoints
- [GET /xcloud/v1/customers/{customerId}](v1-customers-customerId-get.md) - Get full customer details
- [GET /xcloud/v1/customers](v1-customers-get.md) - List all customers
- [POST /xcloud/v1/customers](v1-customers-post.md) - Register new customer
- [PUT /xcloud/v1/customers/{customerId}](v1-customers-customerId-put.md) - Update customer