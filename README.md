# Music API

Simple REST API for music releases built with Ruby on Rails.

## Features

* List music releases
* Include album and artist information
* Filter by past or upcoming releases
* Pagination support
* RSpec tests
* Docker support

## Tech Stack

* Ruby on Rails
* PostgreSQL
* RSpec
* Docker

## Running the Project

### Using Docker

Build containers:

docker compose build

Create database:

docker compose run web ./bin/rails db:create

Run migrations:

docker compose run web ./bin/rails db:migrate

Start the API:

docker compose up

API will be available at:

http://localhost:3000/api/releases

---

## Running Tests

bundle exec rspec

---

## Example Endpoint

GET /api/releases

Example response:

[
{
"id": 1,
"title": "Test Release",
"release_date": "xxxx-xx-xx",
"album": {"id": 1,
"title": "Test Album"},
"artists": [{"id": 1,
            "name": "Test Artist"}]
}
]

---

## Filtering

/api/releases?filter=past

/api/releases?filter=upcoming

---

## Pagination

/api/releases?page=2

/api/releases?per_page=5

