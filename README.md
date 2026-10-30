# Kim Vladislav Student API

Spring Boot CRUD service for students, containerized with Docker (main by Kim Vladislav).
Author: Kim Vladislav

## Stack
- Java 21, Spring Boot, Gradle
- PostgreSQL
- Docker, Docker Compose
- Jenkins

## Changes by Kim Vladislav
- `GET/PUT/DELETE /api/students/{id}` now returns `404 Not Found` with a JSON
  error body when the student does not exist (before it was `500`).
