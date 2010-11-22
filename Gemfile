source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'active_enum'
gem 'jquery-rails'
gem 'acts_as_url', :git => 'git://github.com/Reprazent/acts_as_url.git'
gem 'will_paginate', '~> 3.0.beta'
gem 'responders'
gem 'thinking-sphinx', :git => 'http://github.com/freelancing-god/thinking-sphinx.git', :branch => 'rails3', :require => 'thinking_sphinx'
gem 'whenever'
gem 'devise'
gem 'state_machine'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'mysql'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'openminds_deploy'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'
group :test do
	gem "sqlite3-ruby", :require => 'sqlite3'
	gem 'capybara'
	gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
	gem 'cucumber-rails', :git => 'git://github.com/robholland/cucumber-rails.git'
	gem "factory_girl" #, :git => "git://github.com/thoughtbot/factory_girl_rails.git"
	gem "test-unit"
	gem "launchy"
	gem "pickle"
end
group :production do
	gem 'exception_notification', :git => 'http://github.com/rails/exception_notification.git', :require => 'exception_notifier'
end
group :development, :test do
	gem 'railroady'
end
# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

