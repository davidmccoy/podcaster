# Podcaster

## Utilities

Sync staging db with production db

```
heroku pg:copy podcaster-beta::DATABASE_URL DATABASE_URL -a podcaster-beta-staging
```

Sync local db with production db

```
dropdb --if-exists podcaster_development && heroku pg:pull DATABASE_URL podcaster_development -a podcaster-beta
```