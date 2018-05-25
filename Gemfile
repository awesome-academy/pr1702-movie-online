source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "cancancan"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.7"
gem "sass-rails", "~> 5.0"
gem "mysql2"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "dotenv-rails", require: "dotenv/load"
gem "ransack"
gem "will_paginate", "3.1.6"
gem "omniauth-facebook"
group :development, :test do
  gem "byebug", platform: :mri
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
