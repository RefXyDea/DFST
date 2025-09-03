# `/xcloud` Endpoint Client API Call Usage Documentation

## Overview
This document catalogs all client API calls to `/xcloud` endpoints in the DFST platform, based on codebase analysis.

## Authentication Services
- **Endpoint:** `/xcloud/auth/login`
  - **Method:** POST
  - **Client:** Angular frontend (fst_web_ui)
  - **Purpose:** User authentication
  - **Payload:** `{ username: string, password: string }`
  - **Response:** JWT token and user profile

- **Endpoint:** `/xcloud/auth/refresh`
  - **Method:** POST
  - **Client:** Angular frontend
  - **Purpose:** Refresh authentication tokens
  - **Payload:** `{ refreshToken: string }`
  - **Response:** New JWT token

## Device Management
- **Endpoint:** `/xcloud/devices/sync`
  - **Method:** POST
  - **Client:** Angular frontend
  - **Purpose:** Synchronize device data
  - **Payload:** `{ devices: Device[], lastSyncTimestamp: number }`
  - **Response:** Updated device data

- **Endpoint:** `/xcloud/devices/status`
# `/xcloud/v2/eventstore` Endpoint Client API Call Analysis

## Identified Endpoints

### 1. `/xcloud/v2/eventstore/data/parsed/observations`
- **Method:** POST
- **Client:** Python client (`vig_tcp` module)
- **Purpose:** Post parsed observation data to the event store
- **Function:** `post_data_loop()`
- **Implementation:** 
  - Messages are pulled from `q_postdata` queue
  - Processed via `post_data()` function which calls `post_observations()`
  - Includes authentication via `api_secret` and `service_id`
- **Response handling:** 
  - Logs responses
  - Checks for failures via `failureCount` field

### 2. `/xcloud/v1/eventstore/data/raw` (related v1 endpoint)
- **Method:** POST
- **Client:** Python client (`vig_tcp` module)
- **Purpose:** Post raw data to the event store
- **Function:** `post_data_loop_esraw()`
- **Implementation:**
  - Similar to v2 endpoint but processes from `q_postdata_esraw` queue
  - Uses the same `post_observations()` function with different path

## Implementation Details
- Both endpoints use a common `post_observations()` function imported from `ProjectModules.xcloud`
- Error handling includes: