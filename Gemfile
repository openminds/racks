source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'active_enum'
gem 'jquery-rails'
gem 'acts_as_url', :git => 'git://github.com/Reprazent/acts_as_url.git'
gem 'will_paginate', '~> 3.0.beta'
gem 'responders'
gem 'thinking-sphinx', '2.0.1'
gem 'whenever'
gem 'devise'
gem 'state_machine'
gem 'prawn', :git => 'git://github.com/sandal/prawn', :tag => '0.10.2', :submodules => true
gem 'convert_colors', :git => 'git://github.com/Reprazent/convert_colors.git'

gem 'mysql'

group :production do
  gem 'exception_notification', :git => 'http://github.com/rails/exception_notification.git', :require => 'exception_notifier'
end

group :test do
  gem "sqlite3-ruby", :require => 'sqlite3'
  gem 'capybara'
  gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
  gem 'cucumber-rails', :git => 'git://github.com/robholland/cucumber-rails.git'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'test-unit'
  gem 'launchy'
  gem 'pickle'
end

group :development, :test do
  gem 'railroady'
  gem 'yUMLmeRails', :git => 'http://github.com/tute/yUMLmeRails.git'
end

group :development do
  gem 'capistrano'
  gem 'openminds_deploy'
end
