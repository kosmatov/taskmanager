require 'test_helper'

class Web::SessionsControllerTest < ActionController::TestCase
  test 'should return new session page' do
    get :new
    assert_response :success
  end

  test  'should create new session' do
    user = FactoryGirl.create(:user)
    post :create, session: { email: user.email, password: user.password }
    assert_response :redirect
  end

  test 'should destroy session' do
    delete :destroy
    assert_response :redirect
  end
end
