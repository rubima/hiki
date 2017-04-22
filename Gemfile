source 'https://rubygems.org'

gem 'rake'
gem 'rack', '~> 1.5.3'
gem 'docdiff'
gem 'hikidoc'

group :development do
  gem 'pry'
  gem 'foreman'
end

group :development, :test do
  gem 'capybara', '< 2'
  gem 'test-unit'
  gem 'test-unit-rr'
  gem 'test-unit-notify'
  gem 'test-unit-capybara'
end

group :production do
  gem 'unicorn'
  gem 'sequel'
  gem 'mysql2'
end
