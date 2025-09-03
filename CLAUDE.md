# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

DFST (Field Smart Technology) is a microservices-based IoT platform for managing and monitoring dewatering equipment. The system consists of multiple Java Spring Boot backend services, an Angular frontend, Python data processing services, and PostgreSQL database.

## Common Development Commands

### Frontend (fst_web_ui)

```bash
# Install dependencies
cd fst_web_ui
npm install --legacy-peer-deps  # Required due to peer dependency conflicts

# Run development server
npm start  # Runs on http://localhost:4200

# Build for production
npm run build

# Run tests with coverage
npm run test:coverage

# Lint the code
npm run lint
```

### Backend Services (Java/Spring Boot)

```bash
# Build a service (example: device management service)
cd fst_device_management_service
mvn -s settings.xml clean compile
mvn -s settings.xml install

# Run tests
mvn test

# Package as JAR
mvn -s settings.xml package
```

### Docker Environment

```bash
# Build Docker images for local development
cd fst-docker
make build

# Run the full stack locally
make run
```

### Python Services (VIG modules)

```bash
# VIG services handle IoT data ingestion
cd vig_tcp  # or vig_rest, vig_updater, etc.
python main.py
```

## High-Level Architecture

### Microservices Structure

The application follows a microservices architecture with Spring Cloud:

1. **Core Services:**
   - `fst_user-service`: User management, authentication, authorization
   - `fst_device_management_service`: Device lifecycle, data logging, fleet management
   - `fst_alarm`: Alarm monitoring and notification system
   - `fst_location`: Location and geo-mapping services
   - `fst_notification_service`: Email/SMS notifications
   - `fst_remote_control`: Remote device control capabilities

2. **Data Ingestion (VIG Services):**
   - `vig_tcp`: TCP-based IoT data receiver
   - `vig_rest`: REST API for device communication
   - `vig_iridium`: Satellite communication handler
   - `vig_orbcomm`: ORBCOMM satellite network integration
   - `vig_updater`: Device firmware update service

3. **Infrastructure:**
   - `fst-cloud-gateway-service`: API Gateway
   - `fst_eureka`: Service discovery
   - `fst_config`: Configuration server
   - `fst-admin-server`: Admin dashboard

4. **Frontend:**
   - `fst_web_ui`: Angular 19 application with ESRI mapping integration

### Database Schema

PostgreSQL database with main schemas:
- Device management (devices, subscriptions, fleet info)
- User management (users, roles, permissions)
- Location data (geo_location, customer mapping)
- Service plans and billing
- Alarm and notification configuration

### Deployment

- Kubernetes deployment using Helm charts (see `charts/` in each service)
- BitBucket pipelines for CI/CD
- Environment-specific configurations (dev, qa, stage, prod)
- AWS services integration (S3, SQS)

### Key Technologies

- **Backend:** Java 21, Spring Boot, Spring Cloud, Maven
- **Frontend:** Angular 19, TypeScript, ESRI Maps, NgRx
- **Database:** PostgreSQL
- **Messaging:** AWS SQS, REST APIs
- **Authentication:** Keycloak/Auth0
- **Monitoring:** DataDog integration
- **Container:** Docker, Kubernetes, Helm

## Testing Strategy

- **Backend:** JUnit, Mockito for unit tests
- **Frontend:** Jest for unit tests, coverage reports in `coverage/lcov-report/`
- **Integration:** Service-level integration tests
- Run tests before committing changes

## Important Patterns

1. **Service Communication:** Services communicate via REST APIs with Spring Cloud discovery
2. **Configuration:** External configuration via Spring Cloud Config server
3. **Data Flow:** IoT devices → VIG services → Message Queue → Core services → Database
4. **Authentication:** Token-based auth with role-based access control
5. **Multi-tenancy:** Location-based data segregation (hubs, regions, customers, sites)

## Key Files and Directories

- `**/pom.xml`: Maven build configuration for Java services
- `**/bitbucket-pipelines.yml`: CI/CD pipeline definitions
- `**/charts/*/values.yaml`: Kubernetes deployment configurations
- `fst-erp-codebase/src/sql/`: Database schema and migration scripts
- `config-repo/`: External configuration properties
- `fst-metadata/src/metadata/`: Internationalization files (multiple languages)