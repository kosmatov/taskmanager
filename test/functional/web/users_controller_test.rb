require 'test_helper'

class Web::UsersControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get user" do
    get :show, id: @user.id
    assert_response :success
  end
  
  test "should get edit page" do
    get :edit, id: @user.id
    assert_response :success
  end
  
  test "should get signup page" do
    get :new
    assert_response :success
  end

  test "should create user" do
    attributes = FactoryGirl.attributes_for(:user)
    post :create, user: attributes
    assert_response :redirect
    
    newuser = User.find_by_email(attributes[:email])
    assert_not_nil newuser
  end

  test "should update user" do
    attributes = FactoryGirl.attributes_for(:user)
    post :update, id: @user, user: attributes
    assert_response :redirect
  end
  
  test "should destroy user" do
    user = FactoryGirl.create(:user)
    delete :destroy, id: user.id
    assert_response :redirect

    assert !User.exists?(user.id)
  end
end
