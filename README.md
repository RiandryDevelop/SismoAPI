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