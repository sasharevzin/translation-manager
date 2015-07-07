# unicorn_rails -c /var/www/translations/current/tmp/sockets/unicorn.sock -E production -D

rails_env = ENV['RAILS_ENV'] || 'production'

# 16 workers and 1 master
worker_processes (rails_env == 'production' ? 16 : 4)

load 'common.rb'
