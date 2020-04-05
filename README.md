# Podcaster

## Requirements

- Ruby
- Rails
- PostgreSQL
- Node
- Yarn
- Redis
- FFMPEG

## Installation

- Clone this repo
- Run `bundle install` to install the Ruby dependencies 
- Run `yarn install` to install the Javascript dependencies
- Create a database
  - Either run `rails db:create` to create a fresh database with no data
  - Or download the production database into your local database with this command: `dropdb --if-exists podcaster_development && heroku pg:pull DATABASE_URL podcaster_development -a podcaster-beta`
- Run the application
  - `rails s` to start the Rails server
  - `bin/webpacker-dev-server` to start the Webpacker server

## Utilities

Sync local db with production db

```
dropdb --if-exists podcaster_development && heroku pg:pull DATABASE_URL podcaster_development -a podcaster-beta
```

Sync staging db with production db

```
heroku pg:copy podcaster-beta::DATABASE_URL DATABASE_URL -a podcaster-beta-staging
```
