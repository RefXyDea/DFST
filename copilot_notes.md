markdown
# `/xcloud` Endpoint Client API Call Use Cases

This document logs all known use cases where client applications (frontend or other services) make API calls to `/xcloud` endpoints within the DFST platform.

## 1. Use Case: Device Data Synchronization

- **Endpoint:** `/xcloud/devices/sync`
- **Client:** Angular frontend (`fst_web_ui`)
- **Purpose:** Synchronize device data between client and backend.
- **Method:** `POST`
- **Payload:** Device list, last sync timestamp.
- **Response:** Updated device data.

## 2. Use Case: User Authentication

- **Endpoint:** `/xcloud/auth/login`
- **Client:** Angular frontend (`fst_web_ui`)
- **Purpose:** User login and token retrieval.
- **Method:** `POST`
- **Payload:** Username, password.
- **Response:** JWT token, user info.

## 3. Use Case: Fetch Device Status

- **Endpoint:** `/xcloud/devices/status`
- **Client:** Angular frontend (`fst_web_ui`)
- **Purpose:** Retrieve real-time status for devices.
- **Method:** `GET`