source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors'
gem 'responders'
gem 'database_cleaner'
gem 'active_model_serializers'
gem 'enumerize'
gem 'fuubar'
gem 'factory_bot_rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano',            '3.13.0', require: false
  gem 'capistrano-bundler',    '1.6.0',  require: false
  gem 'capistrano-rails',      '1.4.0',  require: false
  gem 'capistrano-rvm',        '0.1.2',  require: false
  gem 'capistrano-sidekiq',    '1.0.3',  require: false
  gem 'capistrano3-puma',      '4.0.0',  require: false
end

group :test do
  gem 'shoulda-matchers', '4.0.1'
  gem 'rails-controller-testing'
  gem 'json_spec'
end
