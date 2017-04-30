source 'https://rubygems.org'

# Looking to use the Edge version? gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'

# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use Rack Timeout. Read more: https://github.com/heroku/rack-timeout
gem 'rack-timeout', '~> 0.4'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 0.18'

# Use Redis Rails to set up a Redis backed Cache and / or Session
gem 'redis-rails', '~> 5.0.0.pre'

# Use Sidekiq as a background job processor through Active Job
gem 'sidekiq', '~> 4.2'

# Use Clockwork for recurring background tasks without needing cron
# gem 'clockwork', '~> 2.0'

# Use Kaminari for pagination
# gem 'kaminari', '~> 0.16'

gem 'coderay', '~> 1.1.0'

# Auth
gem 'jwt'
gem 'devise'
# gem 'devise_token_auth'
# gem 'omniauth'

# Frontend -- not used right now, but maybe if you want to add one down the road
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3'
gem 'sass-rails'
gem 'uglifier'
gem 'font-awesome-rails'

gem 'rspec'

group :development, :test do
  # Call 'byebug' anywhere in your code to drop into a debugger console
  gem 'byebug', platform: :mri
  gem 'pry', '~> 0.10.4'
  gem 'pry-remote'
end

group :development do
  # Enable a debug toolbar to help profile your application
  gem 'rack-mini-profiler', '~> 0.10'

  # Access an IRB console on exception pages or by using <%= console %>
  gem 'web-console', '~> 3.3.0'

  # Get notified of file changes. Read more: https://github.com/guard/listen
  gem 'listen', '~> 3.0.5'

  # Use Spring. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
