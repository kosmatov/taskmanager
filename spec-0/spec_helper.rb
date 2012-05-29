require 'spork'
require 'simplecov'


Spork.prefork do

  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'capybara/rails'
  #require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false

    def test_sign_in(user)
      controller.sign_in(user)
    end

    def integration_sign_in(user)
      visit signin_path
      fill_in :session_email, :with => user.email
      fill_in :session_password, :with => user.password
      click_button I18n.t("helpers.submit.session.create")
    end
  end
end

Spork.each_run do
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end
end
