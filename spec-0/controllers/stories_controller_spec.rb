require 'spec_helper'

describe StoriesController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @owner = test_sign_in(FactoryGirl.create(:user))
      @user = FactoryGirl.create(:user, :email => 'other@example.com')
    end

    describe "failure" do

      before(:each) do
        @attr = {
          :content => "",
          :user_id => @user.id
        }
      end

      it "should not create a story" do
        lambda do
          post :create, :story => @attr
        end.should_not change(Story, :count)
      end

      it "should render the user page" do
        post :create, :story => @attr
        response.should render_template('users/show')
      end
    end

    describe "success" do

      before(:each) do
        @attr = {
          :content => "Foo bar",
          :user_id => @user.id
        }
      end

      it "should create a story" do
        lambda do
          post :create, :story => @attr
        end.should change(Story, :count).by(1)
      end

      it "should redirect to the user page" do
        post :create, :story => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        post :create, :story => @attr
        flash[:success].should == I18n.t("flash.story.create")
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        @wrong_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        test_sign_in(@wrong_user)
        @story = FactoryGirl.create(:story, :user => @user, :owner => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @story
        response.should redirect_to(user_path(@wrong_user))
      end
    end

    describe "for and authorized user" do

      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @story = FactoryGirl.create(:story, :user => @user, :owner => @user)
      end

      it "should destroy story" do
        lambda do
          delete :destroy, :id => @story
        end.should change(Story, :count).by(-1)
      end
    end
  end
end
