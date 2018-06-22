source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootstrap-sass"
gem "cancancan"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "dotenv-rails", require: "dotenv/load"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "omniauth-facebook"
gem "pg"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.7"
gem "rails_admin"
gem "ransack"
gem "ratyrate"
gem "sass-rails", "~> 5.0"
gem 'friendly_id', '~> 5.1.0'
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "whenever", require: false
gem "will_paginate", "3.1.6"

group :development, :test do
  gem "byebug", platform: :mri
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
