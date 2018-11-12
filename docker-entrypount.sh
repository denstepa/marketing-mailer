if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi

bundle check || bundle install --jobs 20 --retry 5

if [ ! -f $APP_HOME/config/database.yml ]; then
  echo "Creating database.yml"
  cp $APP_HOME/config/database.example.yml $APP_HOME/config/database.yml
fi

rake db:exists && rake db:migrate || rake db:setup

rails server -p 3012 -b '0.0.0.0'