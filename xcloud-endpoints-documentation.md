# XCloud HTTP Endpoints Documentation

This document provides a comprehensive list of all HTTP endpoint calls to XCloud APIs (`/xcloud` paths) found in the DFST codebase.

## Test vs Production Usage

### Test Code Usage
Test files contain XCloud endpoint calls primarily for:
- **Integration Testing**: Testing actual XCloud API connectivity (often commented out)
- **URL Constants**: Hardcoded test URLs pointing to dev/QA environments
- **Mock Data**: Sample responses from XCloud APIs for unit testing

**Test Files with XCloud References:**
- `fst_alarm/src/test/java/com/xylem/dewatering/alarm/SubscriptionTest.java` - Tests subscription creation
- `fst_location/src/test/java/com/xylem/dewatering/lms/XCloudTest.java` - Tests customer API operations
- `fst_user-service/src/test/java/com/xylem/dewatering/ums/XCloudTest.java` - Tests user management
- `fst_observation_service/src/test/java/com/xylem/dewatering/oms/adapter/ServiceExecutorTests.java` - Mock XCloud responses
- Various `TestConstants.java` files - Contains test URLs and constants

**Common Test URLs:**
- Dev: `https://xc-gcdev-api-gateway.xylem-cloud.com`
- QA: `https://gc-xc-api-gateway.xylem-cloud.com`
- Legacy Prod Test: `http://xcloud-prod-elb-gateway-1156015675.us-east-1.elb.amazonaws.com`

### Production Code Usage
Production code actively uses XCloud endpoints for:

**1. VIG Services (Python - Data Ingestion)**
- `vig_tcp/ProjectModules/post_data.py` - Posts observations and raw data
- `vig_iridium/ProjectModules/post_data.py` - Satellite data posting
- `vig_rest/main.py` - REST-based data ingestion
- `vig_updater/main.py` - Firmware update data
- `vig_orbcomm/vig_library/xcloud.py` - Comprehensive API client library
- `vig_package/xcloud.py` - Shared XCloud client definitions

**2. FST Backend Services (Java - Business Logic)**
- `fst_device_management_service` - Device management operations (uses v1.1)
- `fst_alarm` - Alarm subscription management
- `fst_remote_control` - Remote device commands
- `fst-common-utils` - Shared authentication utilities

**3. Configuration-Driven Endpoints**
Production environments use configuration files to define XCloud hosts:
- **Production**: `https://cloud.xylem.com`
- **QA**: `https://xc-gc-api-gateway.xylem-cloud.com`
- **Dev**: `https://xc-gcdev-api-gateway.xylem-cloud.com`

**Key Production Constants:**
- `XCLOUD_VERSION = "/xcloud/v1.1"` (Device Management Service)
- `AUTHORIZATION_TOKEN_CUSTOMER_LIST = "http://xcloud.xylem.com/tid"` (Multiple services)
- Auth Realms: `https://cloudfront-gc.xylem-cloud.com/xcloud/auth/realms/xcloud`

## Overview

The XCloud APIs are used throughout the DFST system for IoT device management, data ingestion, and various backend services. The endpoints follow two main versions:
- **v1** - Original API version
- **v2** - Enhanced API with additional features for eventstore operations
- **v1.0** - OGC SensorThings API standard endpoints
- **v1.1** - Extended API version

## Base URLs

Different environments use different base URLs:
- Development: `https://xc-gcdev-api-gateway.xylem-cloud.com`
- QA: `https://gc-xc-api-gateway.xylem-cloud.com`
- Production: Configured per environment

## API Endpoints by Category

### 1. Transport Service Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/transports`](endpoints/v1-transports-post.md) | POST | Register transport service | vig_orbcomm, vig_package |
| [`/xcloud/v1/transports`](endpoints/v1-transports-get.md) | GET | Get all transport services | vig_orbcomm, vig_package |
| [`/xcloud/v1/transports/{serviceId}`](endpoints/v1-transports-serviceId-get.md) | GET | Get specific transport service | vig_orbcomm, vig_package |
| [`/xcloud/v1/transports/{serviceId}`](endpoints/v1-transports-serviceId-delete.md) | DELETE | Delete transport service | vig_orbcomm, vig_package |

### 2. Device Protocol Service Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/deviceprotocols`](endpoints/v1-deviceprotocols-post.md) | POST | Register device protocol | vig_orbcomm, vig_package |
| [`/xcloud/v1/deviceprotocols`](endpoints/v1-deviceprotocols-get.md) | GET | Get all device protocols | vig_orbcomm, vig_package |
| [`/xcloud/v1/deviceprotocols/{serviceId}`](endpoints/v1-deviceprotocols-serviceId-get.md) | GET | Get specific protocol by service ID | vig_orbcomm, vig_package |
| [`/xcloud/v1/deviceprotocols/{deviceType}`](endpoints/v1-deviceprotocols-deviceType-get.md) | GET | Get protocol by device type | vig_orbcomm, vig_package |
| [`/xcloud/v1/deviceprotocols/{serviceId}`](endpoints/v1-deviceprotocols-serviceId-delete.md) | DELETE | Delete device protocol | vig_orbcomm, vig_package |

### 3. Application Service Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/applications`](endpoints/v1-applications-post.md) | POST | Register application | vig_orbcomm, vig_package |
| [`/xcloud/v1/applications`](endpoints/v1-applications-get.md) | GET | Get all applications | vig_orbcomm, vig_package |
| [`/xcloud/v1/applications/{serviceId}`](endpoints/v1-applications-serviceId-get.md) | GET | Get specific application | vig_orbcomm, vig_package |
| [`/xcloud/v1/applications/{serviceId}`](endpoints/v1-applications-serviceId-delete.md) | DELETE | Delete application | vig_orbcomm, vig_package |
| [`/xcloud/v1/applications/{serviceId}`](endpoints/v1-applications-serviceId-patch.md) | PATCH | Update application | vig_orbcomm, vig_package |

### 4. Device Management Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/devices`](endpoints/v1-devices-post.md) | POST | Register device | vig_orbcomm, vig_package |
| [`/xcloud/v1/devices`](endpoints/v1-devices-get.md) | GET | Get all devices | vig_orbcomm, vig_package |
| [`/xcloud/v1/devices?top={top}&skip={skip}`](endpoints/v1-devices-paginated-get.md) | GET | Get devices with pagination | vig_orbcomm, vig_package |
| [`/xcloud/v1/devices/{customerId}/{deviceId}`](endpoints/v1-devices-customerId-deviceId-get.md) | GET | Get specific device | vig_orbcomm, vig_package, fst_help, fst_alarm (test) |
| [`/xcloud/v1/devices?status=ACTIVE&deviceIds={deviceId}`](endpoints/v1-devices-active-get.md) | GET | Get active device by ID | vig_orbcomm |
| [`/xcloud/v1/devices/{customerId}/{deviceId}`](endpoints/v1-devices-customerId-deviceId-patch.md) | PATCH | Update device | vig_orbcomm, vig_package |
| [`/xcloud/v1/devices?status={status}&deviceIds=FST{imei}`](endpoints/v1-devices-imei-query-get.md) | GET | Query device by IMEI and status | fst_help |
| [`/xcloud/v1.1/devices`](endpoints/v1-1-devices.md) | Various | Device operations (v1.1) | fst_device_management_service |

### 5. EventStore Subscription Endpoints

#### Raw Data Subscriptions
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/eventstore/subscriptions/raw`](endpoints/v1-eventstore-subscriptions-raw-post.md) | POST | Create raw data subscription | vig_orbcomm, vig_package |
| [`/xcloud/v1/eventstore/subscriptions/raw`](endpoints/v1-eventstore-subscriptions-raw-get.md) | GET | Get all raw subscriptions | vig_orbcomm, vig_package |
| [`/xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}`](endpoints/v1-eventstore-subscriptions-raw-id-get.md) | GET | Get specific raw subscription | vig_orbcomm, vig_package |
| [`/xcloud/v1/eventstore/subscriptions/raw/{subscriptionId}`](endpoints/v1-eventstore-subscriptions-raw-id-delete.md) | DELETE | Delete raw subscription | vig_orbcomm, vig_package |

#### Parsed Data Subscriptions
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/eventstore/subscriptions/parsed`](endpoints/v1-eventstore-subscriptions-parsed-post.md) | POST | Create parsed data subscription | vig_orbcomm, vig_package, fst_alarm |
| [`/xcloud/v1/eventstore/subscriptions/parsed`](endpoints/v1-eventstore-subscriptions-parsed-get.md) | GET | Get all parsed subscriptions | vig_orbcomm, vig_package |
| [`/xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}`](endpoints/v1-eventstore-subscriptions-parsed-id-get.md) | GET | Get specific parsed subscription | vig_orbcomm, vig_package |
| [`/xcloud/v1/eventstore/subscriptions/parsed/{subscriptionId}`](endpoints/v1-eventstore-subscriptions-parsed-id-delete.md) | DELETE | Delete parsed subscription | vig_orbcomm, vig_package |

### 6. EventStore Data Endpoints

#### Version 1 Endpoints
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/eventstore/data/raw`](endpoints/v1-eventstore-data-raw-post.md) | POST | Post raw data | vig_tcp, vig_iridium, vig_rest, vig_updater, vig_orbcomm, vig_package |
| [`/xcloud/v1/eventstore/data/parsed`](endpoints/v1-eventstore-data-parsed-post.md) | POST | Post parsed data | vig_orbcomm, vig_package |

#### Version 2 Endpoints (Enhanced)
| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v2/eventstore/data/parsed/things`](endpoints/v2-eventstore-data-parsed-things-post.md) | POST | Post things data | vig_orbcomm |
| [`/xcloud/v2/eventstore/data/parsed/datastreams`](endpoints/v2-eventstore-data-parsed-datastreams-post.md) | POST | Post datastreams | vig_orbcomm |
| [`/xcloud/v2/eventstore/data/parsed/observations`](endpoints/v2-eventstore-data-parsed-observations-post.md) | POST | Post observations | vig_tcp, vig_iridium, vig_rest, vig_updater, vig_orbcomm |
| [`/xcloud/v2/eventstore/data/parsed/alarms`](endpoints/v2-eventstore-data-parsed-alarms-post.md) | POST | Post alarms | vig_orbcomm |
| [`/xcloud/v2/eventstore/`](endpoints/v2-eventstore.md) | Various | Main v2 eventstore path (configured) | vig_tcp |

### 7. Customer Management Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/customers`](endpoints/v1-customers-post.md) | POST | Register customer | vig_orbcomm, vig_package, sitesfromexstcust, fst_location (test) |
| [`/xcloud/v1/customers`](endpoints/v1-customers-get.md) | GET | Get all customers | vig_orbcomm, vig_package, sitesfromexstcust, fst_location (test) |
| [`/xcloud/v1/customers/{customerId}`](endpoints/v1-customers-customerId-get.md) | GET | Get specific customer | vig_orbcomm, vig_package, fst_location (test) |
| [`/xcloud/v1/customers/{customerId}`](endpoints/v1-customers-customerId-put.md) | PUT | Update customer | vig_orbcomm, vig_package, fst_location (test) |
| [`/xcloud/v1/customers/{customerIds}`](endpoints/v1-customers-customerIds-head.md) | HEAD | Check if customers exist | vig_orbcomm, vig_package |
| [`/xcloud/v1.1/customers?status=INACTIVE`](endpoints/v1-1-customers-inactive-get.md) | GET | Get inactive customers | fst_location (test) |

### 8. User Management Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/users`](endpoints/v1-users-get.md) | GET | Get users with pagination | fst_user-service (test) |
| [`/xcloud/v1/users/{userId}`](endpoints/v1-users-userId-get.md) | GET | Get specific user | fst_user-service (test), fst_remote_control (test) |
| [`/xcloud/v1/users?page={page}&size={size}`](endpoints/v1-users-paginated-get.md) | GET | Get users paginated | fst_user-service (test), fst_location (test) |

### 9. Sensing Sites Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1/sensingsites`](endpoints/v1-sensingsites-get.md) | GET | Get all sensing sites | sitesfromexstcust |
| [`/xcloud/v1/sensingsites`](endpoints/v1-sensingsites-post.md) | POST | Create sensing site | sitesfromexstcust |
| [`/xcloud/v1/sensingsites/{site_id}`](endpoints/v1-sensingsites-siteId-get.md) | GET | Get specific site | sitesfromexstcust |
| [`/xcloud/v1/sensingsites?page={page}&size={size}&sort={sort}`](endpoints/v1-sensingsites-paginated-get.md) | GET | Get sites with pagination and sorting | sitesfromexstcust |

### 10. OGC SensorThings API Endpoints

| Endpoint | Method | Description | Usage |
|----------|--------|-------------|--------|
| [`/xcloud/v1.0/Things`](endpoints/v1-0-things-get.md) | GET | Get all things | vig_orbcomm, vig_package, fst_alarm (test) |
| [`/xcloud/v1.0/Thing({iot_id})`](endpoints/v1-0-thing-iotId-get.md) | GET | Get specific thing | vig_orbcomm, vig_package |
| [`/xcloud/v1.0/Things({iot_id})/Datastreams`](endpoints/v1-0-things-iotId-datastreams-get.md) | GET | Get thing datastreams | vig_orbcomm, vig_package |
| [`/xcloud/v1.0/Things({iot_id})/Locations`](endpoints/v1-0-things-iotId-locations-get.md) | GET | Get thing locations | vig_orbcomm, vig_package |
| [`/xcloud/v1.0/Things?$top={top}&$skip={skip}`](endpoints/v1-0-things-odata-get.md) | GET | Get things with OData pagination | vig_orbcomm, vig_package |
| [`/xcloud/v1.0/Datastreams({iot_id})`](endpoints/v1-0-datastreams-iotId-get.md) | GET | Get specific datastream | vig_orbcomm, vig_package |
| [`/xcloud/v1.0/Datastreams({iot_id})/Observations`](endpoints/v1-0-datastreams-iotId-observations-get.md) | GET | Get datastream observations | vig_orbcomm, vig_package |

## Webhook Endpoints (Registered via Subscriptions)

When services POST to `/xcloud/v1/eventstore/subscriptions/parsed` or `/xcloud/v1/eventstore/subscriptions/raw`, they register callback URLs that XCloud will POST data to. Here are the registered webhook endpoints:

### Remote Control Service Webhooks

| Webhook Endpoint | Purpose | Registration Code | Implementation Code | Environment URLs |
|------------------|---------|-------------------|---------------------|------------------|
| [`/incomingsubdata/commandstatus`](endpoints/webhook-rcs-commandstatus.md) | Receives command status updates | [SubscribeToXCloudServiceImpl.java:65](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java#L65)<br>[generateParsedCommandStatusSubscriptionCallbackUri()](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java#L121) | [IncomingSubscriptionDataController.java:47](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/controller/IncomingSubscriptionDataController.java#L47) | Production: `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/commandstatus`<br>QA: `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/remote-control-service/incomingsubdata/commandstatus`<br>Dev: `https://18.221.161.197:8099/ws/api/remote-control-service/incomingsubdata/commandstatus` |
| [`/incomingsubdata/alarms`](endpoints/webhook-rcs-alarms.md) | Receives alarm notifications | [SubscribeToXCloudServiceImpl.java:172](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java#L172)<br>[generateParsedAlarmsSubscriptionCallbackUri()](../fst_remote_control/src/main/java/com/xylem/dewatering/rcs/service/impl/SubscribeToXCloudServiceImpl.java#L217) | **NOT IMPLEMENTED** - Registration exists but no handler endpoint found | Production: `https://cloud.xylem.com/fst/api/remote-control-service/incomingsubdata/alarms`<br>QA: `https://cloudfront-gc.xylem-cloud.com/qa-fst/api/remote-control-service/incomingsubdata/alarms`<br>Dev: `https://cloudfront-gc.xylem-cloud.com/dev-fst/api/remote-control-service/incomingsubdata/alarms` |

### Production Webhook Summary

**Active Production Webhooks:**
- Only the **Remote Control Service** has active webhook registration and implementation in production code
- The `/incomingsubdata/commandstatus` endpoint is fully implemented and operational
- The `/incomingsubdata/alarms` endpoint has registration code but **no implementation** - this appears to be incomplete functionality

**No Other Production Webhooks Found:**
- VIG services (vig_orbcomm, vig_package, etc.) do not register webhooks - they only POST data to XCloud
- Alarm service does not have production webhook registration code

### Webhook Authentication
All webhook callbacks from XCloud include:
- **Authorization** header with HMAC-SHA256 signature
- **Date** header with timestamp
- **Content-Type**: application/json

The receiving service must validate the HMAC signature using the shared secret key.

## Service Usage Summary

### VIG Services (IoT Data Ingestion)
- **vig_tcp**: Posts observations (v2) and raw data (v1)
- **vig_iridium**: Posts observations (v2) and raw data (v1) for satellite communication
- **vig_rest**: Posts observations (v2) and raw data (v1) via REST
- **vig_updater**: Posts observations (v2) and raw data (v1) for firmware updates
- **vig_orbcomm**: Comprehensive usage of all endpoint categories
- **vig_package**: Shared library with endpoint definitions

### FST Services (Backend Services)
- **fst_device_management_service**: Device management (v1.1)
- **fst_user-service**: User management (test only - actual calls to XCloud)
- **fst_location**: Location services and customer management (test only - actual calls to XCloud)
- **fst_alarm**: Alarm subscriptions via eventstore
- **fst_remote_control**: Remote device control
- **fst_help**: Device registry helper functions

### Utility Services
- **sitesfromexstcust**: Customer and site management utilities

## Authentication & Headers

Most endpoints require:
- **Authorization**: Bearer token or API key
- **Content-Type**: application/json
- **Content-MD5**: For certain POST/PUT operations (when md5=True)
- **Security**: HMAC-SHA256 signatures for sensitive operations

## Constants & Configuration

Key constants found in the codebase:
- `XCLOUD_VERSION = "/xcloud/v1.1"` (fst_device_management_service)
- `AUTHORIZATION_TOKEN_CUSTOMER_LIST = "http://xcloud.xylem.com/tid"`
- Device ID format: `FST{imei}` or `FST-{timestamp}-{id}`

## Notes

1. **Version Migration**: The system is transitioning from v1 to v2 for eventstore operations, with v2 providing enhanced data structure for things, datastreams, observations, and alarms.

2. **OGC Compliance**: The v1.0 endpoints follow the OGC SensorThings API standard for IoT data representation.

3. **Pagination**: Different endpoints use different pagination patterns:
   - Standard: `?page={page}&size={size}`
   - Alternative: `?top={top}&skip={skip}`
   - OData: `?$top={top}&$skip={skip}`

4. **Environment-Specific URLs**: The base URLs vary by environment (dev, qa, prod) and are configured in environment-specific property files.

5. **Service Registration**: Transport and device protocol services must be registered before devices can send data.