require 'rubygems'
require 'fileutils'

# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

##################################################################################

Capybara.configure do |config|
  config.server = :puma
  config.default_max_wait_time = 15
end

##################################################################################

require 'selenium/webdriver'

Capybara.register_driver :selenium_firefox do |app|
  if ENV['FIREFOX_ESR_45_PATH'].present?
    Selenium::WebDriver::Firefox::Binary.path = ENV['FIREFOX_ESR_45_PATH']
  end
  profile = Selenium::WebDriver::Firefox::Profile.new
  Capybara::Selenium::Driver.new app, browser: :firefox, profile: profile
end

##################################################################################

Before('@ldap') do
  ENV['TMPDIR'] = File.join(Rails.root, 'tmp')
  # TODO: Move this out to something that runs *before* the test suite itself?
  Dir.mkdir(ENV['TMPDIR']) unless File.exist?(ENV['TMPDIR'])
  Setting::LDAP_CONFIG = File.join(Rails.root, 'features', 'data', 'LDAP_generic.yml')
  @ldap_server =
    Ladle::Server.new(
      port: 12345,
      ldif: File.join(Rails.root, 'features', 'data', 'ldif', 'generic.ldif'),
      domain: 'dc=example,dc=org'
    )
  @ldap_server.start
end

Before('~@rack') do
  Capybara.current_driver = :selenium_firefox
  # to prevent Selenium::WebDriver::Error::MoveTargetOutOfBoundsError: Element cannot be scrolled into view
  page.driver.browser.manage.window.maximize
end

Before do
  Cucumber.logger.info 'Current capybara driver: %sundefined' % Capybara.current_driver
  Dataset.restore_dump
end

##################################################################################

After('@ldap') { @ldap_server.stop }
