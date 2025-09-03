# POST /xcloud/v1/eventstore/subscriptions/raw

## Overview
Creates a subscription for raw event data from XCloud. When raw events matching the filter criteria occur, XCloud will POST the raw data to the specified webhook callback URL.

## Endpoint Details
- **Path**: `/xcloud/v1/eventstore/subscriptions/raw`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: Required (HMAC-SHA256 with Content-MD5)

## Request Body Structure
```json
{
  "subscriberServiceID": "string",
  "callBackConnection": {
    "connectionType": "REST",
    "connectionDetails": {
      "uri": "string"
    }
  },
  "filter": {
    "filterType": "ATTRIBUTE",
    "attributeFilter": {
      "filterName": "string",
      "attributeName": "string",
      "attributeValues": ["string"]
    }
  }
}
```

## Response
### Success Response (200 OK)
```json
{
  "subscriptionId": "string",
  "status": "ACTIVE",
  "createdAt": "2024-01-01T00:00:00Z",
  "webhookUrl": "string"
}
```

## Production Instances

### VIG Services (Python Data Ingestion)

#### vig_tcp Service
**Implementation:** [`vig_tcp/main.py`](../vig_tcp/main.py) with [`vig_tcp/ProjectModules/post_data.py:post_data_loop_esraw()`](../vig_tcp/ProjectModules/post_data.py)
- **Purpose:** TCP-based IoT data receiver that posts raw event store data
- **Data Flow:** Receives device commands → Posts to `/xcloud/v1/eventstore/data/raw`
- **Transport Types:** Uses `vig_tps` service credentials
- **Configuration:** Via Vault (`vig_tps.apiSecret`, `vig_tps.serviceId`)

#### vig_orbcomm Service  
**Implementation:** [`vig_orbcomm/vig_orbcomm.py`](../vig_orbcomm/vig_orbcomm.py) with [`vig_orbcomm/vig_library/xcloud.py`](../vig_orbcomm/vig_library/xcloud.py)
- **Purpose:** ORBCOMM satellite communication handler
- **XCloud Library:** Defines `subscribe_raw` endpoint configuration
- **Base URL:** `https://gc-xc-api-gateway.xylem-cloud.com`
- **Authentication:** HMAC-SHA256 with Content-MD5

#### vig_package Library
**Implementation:** [`vig_package/xcloud.py`](../vig_package/xcloud.py)
- **Purpose:** Shared library for XCloud communication across VIG services
- **Raw Subscription Support:**
  ```python
  "subscribe_raw": {"path":"/xcloud/v1/eventstore/subscriptions/raw", "verb":"POST", "md5":True}
  ```

### Configuration-Driven Subscriptions (Java Services)

#### fst_remote_control Service
**Configuration Properties:**
- **rawSubscriptionPath:** `/eventstore/subscriptions/raw`
- **rawSubCommandAttributeName:** `transportType`
- **rawSubCommandAttributeValues:** `vigTpsLegacy,vigTpsQ4000`
- **rawSubCommandFilterName:** `vigDps`
- **rawSubCommandFilterType:** `ATTRIBUTE`

**Environment-Specific Configuration:**
- **Production:** [`config-repo/remote-control-service-prod.properties`](../config-repo/remote-control-service-prod.properties)
- **QA:** [`config-repo/remote-control-service-qa.properties`](../config-repo/remote-control-service-qa.properties)  
- **Development:** [`config-repo/remote-control-service-dev.properties`](../config-repo/remote-control-service-dev.properties)

## QA/Staging Instances

### VIG Services (QA)
- **XCloud Host:** `xc-gc-api-gateway.xylem-cloud.com`
- **Base URL:** `https://xc-gc-api-gateway.xylem-cloud.com`
- **Same VIG services as production but pointed to QA XCloud environment**

### fst_remote_control Service (QA)
- **Configuration:** Uses QA-specific URLs and credentials
- **Raw subscription configuration available but managed externally**

## Test/Development Instances

### VIG Services (Development)
- **XCloud Host:** `xc-gcdev-api-gateway.xylem-cloud.com` (dev environment)
- **Local Development:** IP-based endpoints for testing
- **Test Data:** Simulated device data when not in production environment

### fst_remote_control Service (Development)
- **Configuration:** [`config-repo/remote-control-service-dev.properties`](../config-repo/remote-control-service-dev.properties)
- **Development endpoints:** IP-based callback URLs

## Key Implementation Details

### Python VIG Services
The VIG (data ingestion) services use raw subscriptions primarily for:
1. **Data Posting:** Raw device data collection
2. **Transport Protocols:** Legacy and Q4000 transport types
3. **Event Store Integration:** Direct posting to `/xcloud/v1/eventstore/data/raw`

### Raw Subscription Filter Configuration
From `fst_remote_control` properties:
```properties
rawSubCommandAttributeName=transportType
rawSubCommandAttributeValues=vigTpsLegacy,vigTpsQ4000
rawSubCommandFilterName=vigDps
rawSubCommandFilterType=ATTRIBUTE
```

### Authentication
Raw subscriptions require enhanced security:
- **HMAC-SHA256** signature
- **Content-MD5** hash (when `md5=True`)
- **Authorization** header format: `xCloud <base64(serviceId)>:<signature>`
- **Date** header with ISO timestamp

## Data Flow Architecture

### Raw Data Pipeline
1. **Device** → **VIG Service** (vig_tcp, vig_orbcomm, etc.)
2. **VIG Service** → **XCloud Raw Event Store** (`/xcloud/v1/eventstore/data/raw`)
3. **XCloud** → **Subscribed Services** (via webhook callbacks)

### Transport Types
- `vigTpsLegacy`: Legacy transport protocol
- `vigTpsQ4000`: Q4000 device transport protocol
- `xylemFstQ4000Command`: Command transport (different from raw data)

## Environment URLs

### Production
- **XCloud API:** `https://gc-xc-api-gateway.xylem-cloud.com`
- **FST Services:** `https://cloud.xylem.com/fst/api/`

### QA
- **XCloud API:** `https://xc-gc-api-gateway.xylem-cloud.com` 
- **FST Services:** `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/`

### Development
- **XCloud API:** `https://xc-gcdev-api-gateway.xylem-cloud.com`
- **FST Services:** Various development endpoints

## Related Endpoints
- [GET /xcloud/v1/eventstore/subscriptions/raw](v1-eventstore-subscriptions-raw-get.md) - List raw subscriptions
- [DELETE /xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}](v1-eventstore-subscriptions-raw-id-delete.md) - Delete raw subscription
- [POST /xcloud/v1/eventstore/subscriptions/parsed](v1-eventstore-subscriptions-parsed-post.md) - Subscribe to parsed data
- [POST /xcloud/v1/eventstore/data/raw](v1-eventstore-data-raw-post.md) - Post raw data