# Transportation Management System API

Transportation Management System API is a robust and scalable backend solution that is designed to manage drivers, trucks, and assignments efficiently. Built with Ruby on Rails and following JSON:API specifications, this system offers a seamless experience for managing transportation logistics.

## Features

- **JWT Authentication**: Secure endpoints with JSON Web Tokens
- **JSONAPI-compliant**: Standardized API responses for easy integration
- **Periodic Data Fetching**: Automated truck data synchronization from external API
- **Dockerized**: Easy setup and deployment with Docker
- **Comprehensive Testing**: Ensuring reliability and maintainability

## Tech Stack

- **Ruby on Rails**: Web application framework
- **PostgreSQL**: Robust, scalable database
- **Sidekiq**: Background job processing
- **Redis**: In-memory data structure store
- **RSpec**: Comprehensive testing framework
- **Docker**: Containerization for consistent environments

## API Endpoints

### Authentication

- **POST /v1/register**: Register a new driver
  - Params: `email`, `password`
  - Returns: JWT token

- **POST /v1/login**: Authenticate a driver
  - Params: `email`, `password`
  - Returns: JWT token

### Trucks

- **GET /v1/trucks**: List all trucks (Authenticated)
  - Returns: Paginated list of trucks

- **POST /v1/trucks/:id/assign**: Assign truck to current driver (Authenticated)
  - Params: `id` (truck_id)
  - Returns: Updated truck details

- **GET /v1/trucks/assigned**: List trucks assigned to current driver (Authenticated)
  - Returns: Paginated list of assigned trucks

## Getting Started

1. Clone the repository
2. Create a `.env` file in the root directory with the following content:
   ```
   JWT_SECRET=your_jwt_secret
   EXTERNAL_API_KEY=illa-trucks-2023
   REDIS_URL=redis://redis:6379/1
   ```
3. Run `docker-compose up`
4. The API will be available at `http://localhost:3000`

## Project Structure

- `app/controllers/v1`: API controllers
- `app/models`: ActiveRecord models
- `app/jobs`: Background jobs (e.g., FetchTrucksJob)
- `config/routes.rb`: API route definitions
- `spec`: RSpec test files

## Best Practices & Key Features

1. **JWT Authentication**: Custom implementation using `bcrypt` and `jwt` gems for secure, stateless authentication.

2. **JSON:API Compliance**: Utilized `jsonapi-serializer` for standardized API responses, enhancing interoperability.

3. **Background Job Processing**: Implemented `FetchTrucksJob` using Sidekiq for efficient, scheduled data synchronization from external API.

4. **Pagination**: Integrated `pagy` gem for efficient, database-agnostic pagination.

5. **Comprehensive Testing**: Extensive unit and integration tests using RSpec, FactoryBot, and Faker for robust test coverage.

6. **Docker Integration**: Fully dockerized application for consistent development and deployment environments.

7. **Database Optimization**: Utilized ActiveRecord associations and indexing for efficient querying.

8. **API Versioning**: Implemented versioning (v1) for better API lifecycle management.

9. **Environment Variable Management**: Used `dotenv` for secure management of environment-specific configurations.

10. **Code Quality**: Adhered to Ruby style guide and used Rubocop for consistent code styling.

## Monitoring

Access Sidekiq dashboard at `/sidekiq` to monitor background jobs.

## Running Tests

Execute `docker-compose run web rspec` to run the test suite.
