# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'simplecov' 
require 'cucumber/rails'
require 'rspec/rails'
SimpleCov.start 'rails' 


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

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

# ---------- Seed test database before cucumber tests, and clean up after ----------
Before do
  unless @database_seeded
    Rails.application.load_seed
    @database_seeded = true
  end
end

at_exit do
  ActiveRecord::Base.subclasses.each(&:delete_all)
end

# ---------- OmniAuth Mock OAuth ----------
# https://stackoverflow.com/questions/20848124/testing-omniauth-with-cucumber/20851644
# These pair with the @ labels above scenarios in login.feature
Before('@MockLogInWithColumbia') do
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://example.com'

  OmniAuth.config.add_mock(:google_oauth2, {
    :uid => '1000',
    :credentials => {
      :token => 'x',
      :expires_at => 9999999999
    },
    :info => {
      :email => 'test_x@columbia.edu',
      :first_name => 'Columbia',
      :last_name => 'User',
      :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
    }
  })
end

After('@MockLogInWithColumbia') do
  OmniAuth.config.test_mode = false
end

Before('@MockLogInWithTC') do
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://example.com'

  OmniAuth.config.add_mock(:google_oauth2, {
    :uid => '1001',
    :credentials => {
      :token => 'x',
      :expires_at => 9999999999
    },
    :info => {
      :email => 'test_x@tc.columbia.edu',
      :first_name => 'TC',
      :last_name => 'User',
      :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
    }
  })
end

After('@MockLogInWithTC') do
  OmniAuth.config.test_mode = false
end

Before('@MockLogInWithBarnard') do
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://example.com'

  OmniAuth.config.add_mock(:google_oauth2, {
    :uid => '1002',
    :credentials => {
      :token => 'x',
      :expires_at => 9999999999
    },
    :info => {
      :email => 'test_x@barnard.edu',
      :first_name => 'Barnard',
      :last_name => 'User',
      :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
    }
  })
end

After('@MockLogInWithBarnard') do
  OmniAuth.config.test_mode = false
end

Before('@MockLogInWithGmail') do
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://example.com'

  OmniAuth.config.add_mock(:google_oauth2, {
    :uid => '1003',
    :credentials => {
      :token => 'x',
      :expires_at => 9999999999
    },
    :info => {
      :email => 'test_x@gmail.com',
      :first_name => 'Gmail',
      :last_name => 'User',
      :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
    }
  })
end

After('@MockLogInWithGmail') do
  OmniAuth.config.test_mode = false
end

Before('@MockLogInWithFakeColumbia') do
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://example.com'

  OmniAuth.config.add_mock(:google_oauth2, {
    :uid => '1004',
    :credentials => {
      :token => 'x',
      :expires_at => 9999999999
    },
    :info => {
      :email => 'test_x@fakecolumbia.edu',
      :first_name => 'FakeColumbia',
      :last_name => 'User',
      :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
    }
  })
end

After('@MockLogInWithFakeColumbia') do
  OmniAuth.config.test_mode = false
end

Before('@InvalidLogin') do
  puts("------------------ [Cucumber] OmniAuth Errors below are EXPECTED. Invalid login test started ------------------")
end

After('@InvalidLogin') do
  puts("------------------ [Cucumber] OmniAuth Errors above are EXPECTED. Invalid login test finished ------------------")
end
