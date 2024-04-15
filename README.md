# Sismo App README

Welcome to Sismo App, an application that retrieves and delivers reports on seismological events around the world.

This README document covers the necessary steps to get the application up and running.

## Ruby version

This project is developed using Ruby version 3.2.3.

## System dependencies

Make sure you have the following dependencies installed on your system:

- Ruby 3.2.3
- Rails 7.1.3.2
- SQLite3
- Puma web server

Additionally, ensure you have `rest-client`, `ffi`, and `will_paginate` gems installed.

## Configuration

Clone the project repository to your local machine:

```bash
git clone <repository_url>
```

Navigate to the project directory:

```bash
cd <project_directory>
```

Install gem dependencies:

```bash
bundle install
```

## Database creation

The project uses SQLite3 as the database for Active Record. To create the database, run the following command:

```bash
rails db:create
```

## Database initialization

Once the database is created, you can initialize it by running migrations:

```bash
rails db:migrate
```

## How to run the test suite

To run the test suite, execute the following command:

```bash
rails test
```

## Services

No additional services are required to run this application.

## Deployment instructions

To deploy this application, you can follow standard Rails deployment procedures. Ensure to set up your production environment configuration appropriately.

That's it! Your project should now be set up and ready to run.


## How to use the api service

## Endpoints

- **Get all features**
  - Endpoint: `GET /api/features`
  - Description: Retrieves a list of all features available in the system.

- **Get all comments of a particular feature**
  - Endpoint: `GET /api/comments/feature/:feature_id`
  - Description: Retrieves all comments associated with a specific feature identified by `feature_id`.

- **Create a comment**
  - Endpoint: `POST /api/comments`
  - Description: Creates a new comment for a feature.
  - Request Body: JSON object with the following parameters:
    - `feature_id`: ID of the feature the comment belongs to.
    - `body`: Text content of the comment.

- **Update a comment**
  - Endpoint: `PUT /api/comments/:comment_id`
  - Description: Updates an existing comment identified by `comment_id`.
  - Request Body: JSON object with the following parameter:
    - `body`: Updated text content of the comment.

- **Delete a comment**
  - Endpoint: `DELETE /api/comments/:comment_id`
  - Description: Deletes a comment identified by `comment_id`.


## Response Format

- Success Response: HTTP status code 200 OK for successful requests.
- Error Response: HTTP status codes indicating the type of error occurred, along with a relevant error message in the response body.

## Authentication

This API does not require authentication for accessing the endpoints. However, ensure proper authorization mechanisms are implemented in your application if needed.

## Rate Limiting

There are currently no rate limits enforced on this API. However, consider implementing rate limiting on your client-side to prevent abuse.

## Versioning

This documentation corresponds to version 1 of the API. Any future updates or changes will be documented accordingly.

