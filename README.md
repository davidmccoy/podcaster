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
- Install Ruby 2.7.5 (e.g. `rbenv install 2.7.5`)
-
- Run `bundle install` to install the Ruby dependencies
- Run `yarn install` to install the Javascript dependencies
- Get `application.yml` file from Keybase and put it in the `config/` directory
- Create a database
  - **Either:** run `rails db:create` to create a fresh database with no data
  - **Or:** download the production database into your local database with this command: `dropdb --if-exists podcaster_development && heroku pg:pull DATABASE_URL podcaster_development -a podcaster-beta`
- Run the application
  - `rails s` to start the Rails server
  - `bin/webpack-dev-server` to start the Webpacker server

## Utilities

Sync local db with production db

```
dropdb --if-exists podcaster_development && heroku pg:pull DATABASE_URL podcaster_development -a podcaster-beta
```

Sync staging db with production db

```
heroku pg:copy podcaster-beta::DATABASE_URL DATABASE_URL -a podcaster-beta-staging
```

Sync staging s3 buckets with production s3 buckets. (Images and audio are stored separately.)

```
aws s3 sync s3://mtgcast-images s3://mtgcast-images-staging
aws s3 sync s3://mtgcast-podcasts s3://mtgcast-podcasts-staging
```



## Errors

### `bin/webpack-dev-server` ssl error:

workaround:

export NODE_OPTIONS=--openssl-legacy-provider

https://github.com/webpack/webpack/issues/14532
