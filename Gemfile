eval_gemfile Pathname(File.dirname(File.absolute_path(__FILE__))).join('database', 'Gemfile')

gem 'leihs_admin', path: "engines/leihs_admin"

gem 'puma'

gem 'audited', git: 'https://github.com/leihs/audited', branch: 'master'
gem 'axlsx', git: 'https://github.com/leihs/axlsx', ref: 'c8ac844572b25fda358cc01d2104720c4c42f450'
gem 'barby', '~> 0.5.0'
gem 'chunky_png', '~> 1.2'
gem 'cider_ci-open_session', '~> 2.0.1'
gem 'coffee-rails', '~> 4.0'
gem 'coffee-script', '~> 2.2'
gem 'compass-rails', '~> 3.0'
gem 'execjs', '~> 2.6'
gem 'font-awesome-sass', '~> 4.4' # NOTE font not found using gem 'rails-assets-font-awesome'
gem 'geocoder', '~> 1.1'
gem 'gettext_i18n_rails', '~> 1.0'
gem 'haml', '~> 4.0'
gem 'jquery-tmpl-rails', '~> 1.1'
gem 'json', '~> 1.8'
gem 'jsrender-rails', git: 'https://github.com/leihs/jsrender-rails', branch: 'master'
gem 'kramdown' # markdown rendering
gem 'liquid', '~> 3.0'
gem 'mini_magick', '~> 3.4'
gem 'mini_racer'
gem 'net-ldap', require: 'net/ldap'
gem 'nilify_blanks', '~> 1.1'
gem 'presentoir', git: 'https://github.com/leihs/presentoir', ref: '1f65b6a673be93f9babb17f26f3bacaf64a7fbc2'
gem 'rails_autolink', '~> 1.0'
gem 'rake' # So that cronjobs work -- otherwise they can't find rake
gem 'rinku', '~> 2.0.4', require: false
gem 'rgl', '~> 0.4.0', require: 'rgl/adjacency' # use ruby-graphviz instead ?? (already in test group)
gem 'ruby_parser', '~> 3.1' # gettext dependency that Bundler seems unable to resolve
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '~> 2.4'
gem 'will_paginate', '~> 3.0'


# JavaScript / Frontend / Client [modern]
gem 'webpacker', '~> 3.0'
gem 'react-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-accounting.js', '~> 0.4'
  gem 'rails-assets-fullcalendar', '~> 1.5'
  gem 'rails-assets-jquery', '~> 1.5'
  gem 'rails-assets-jquery-autosize', '~> 1.18'
  gem 'rails-assets-jquery.inview', '1.0.0'
  gem 'rails-assets-jquery-ui', '~> 1.1'
  gem 'rails-assets-jquery-ujs', '~> 1.0'
  gem 'rails-assets-moment', '~> 2.10'
  gem 'rails-assets-moment-range', '2.2'
  gem 'rails-assets-timecop', '~> 0.1'
  gem 'rails-assets-underscore', '~> 1.8'
  # gem 'rails-assets-spine', '~> 1.3.0'
  # gem 'rails-assets-uri.js', '~> 1.16'
end

group :development do
  gem 'metric_fu'
  gem 'traceroute'
  gem 'web-console'
  # gem 'web-console', '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views
end

group :test do
  gem 'ladle'
  gem 'open4'
  gem 'turnip'
end

group :development, :test do
  gem 'cucumber-rails', '~> 1.4', require: false # it already includes capybara # NOTE '~> 1.4' doesn't work beacause 'gherkin'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.1'
  gem 'flog'
  gem 'flay'
  gem 'meta_request'
  gem 'pry-rails'
  gem 'rb-readline'
  gem 'rspec-rails', '~> 3.6', require: false
  gem 'selenium-webdriver', '~> 2.53'
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'timecop', '~> 0.7'
end
