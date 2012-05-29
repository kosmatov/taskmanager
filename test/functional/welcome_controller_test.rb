require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test 'should return index page' do
    get :index
    assert_response 200
  end
end
