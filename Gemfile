source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'

group :production do
  gem 'pg', '~> 1.2', '>= 1.2.3'
end
group :development, :test do
  # gem 'sqlite3'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem'minitest-reporters'
  gem 'sqlite3'
end

gem 'web-console', '>= 3.3.0', group: :development
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise', '~> 4.7.1'
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'carrierwave-aws'
gem 'carrierwave'
gem 'mini_magick'
gem 'aws-sdk-rails'
gem 'aws-sdk-s3'
gem 'figaro'
gem 'tty-tree'
gem 'rubyzip'
gem 'pry'