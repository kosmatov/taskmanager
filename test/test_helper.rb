require 'simplecov'
SimpleCov.start('rails') if ENV["COVERAGE"]

ENV["RAILS_ENV"] = "test"

#require 'webmock/test_unit'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| require f}
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include AuthHelper
#  include AuthHelper
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  require 'factory_girl'
  FactoryGirl.reload
  # Add more helper methods to be used by all tests here...
end
