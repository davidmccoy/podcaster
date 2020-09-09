web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
worker:  env RAILS_MAX_THREADS=$SIDEKIQ_CONCURRENCY bundle exec sidekiq -C ./config/sidekiq.yml
release: bundle exec rake db:migrate
