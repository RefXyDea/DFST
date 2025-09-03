# DFST (Field Smart Technology) - Meta Repository

This is the main repository for the DFST IoT platform, containing all microservices as Git submodules.

## Quick Start

### Clone with all submodules
```bash
git clone --recurse-submodules <repository-url>
```

### If you've already cloned without submodules
```bash
git submodule update --init --recursive
```

### Update all submodules to latest
```bash
git submodule update --remote
```

## Architecture

DFST is a microservices-based IoT platform with:
- **Backend Services**: Java Spring Boot microservices
- **Frontend**: Angular web application
- **Data Ingestion**: Python VIG services for IoT data
- **Infrastructure**: Docker, Kubernetes, Helm charts

See `CLAUDE.md` for detailed development instructions.

## Submodules

This repository contains 45+ microservices and supporting repositories as Git submodules:
- Core services (user, device management, alarms, etc.)
- VIG data ingestion services
- Configuration and deployment infrastructure
- Frontend applications
- Shared utilities and libraries

Each submodule maintains its own Git history and can be developed independently.