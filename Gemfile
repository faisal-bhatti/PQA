source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'mysql2', '~> 0.3.12'
# Platform specific gems
platforms :ruby do
  gem 'json'
end

# gem 'pg', '~> 0.17.1'

group :development do
  # gem 'sqlite3'
	gem  'mysql2'
end
group :production do
	gem  'mysql2'
	gem 'pg', '~> 0.17.1'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'execjs'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'twilio-ruby'
gem 'mandrill-api', "~> 1.0.42"
gem 'mandrill_mailer'
gem 'jquery-rails'
gem 'sorcery'
gem 'activerecord'
gem 'carrierwave'

# To use ActiveModel has_secure_password
gem 'bcrypt'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
gem 'libv8',  '3.11.8.13'
#gem "therubyracer"
#gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
#gem "twitter-bootstrap-rails"