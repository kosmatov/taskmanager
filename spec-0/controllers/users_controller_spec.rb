require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do

    describe "for non-signed-in users" do

      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:message].should == I18n.t("flash.session.signin")
      end
    end

    describe "for signed-in users" do

      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        second = FactoryGirl.create(:user, :name => "Bob", :email => "another@example.com")
        third = FactoryGirl.create(:user, :name => "Ben", :email => "another@example.net")
        @users = [@user, second, third]
        99.times do
          @users << FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        end
      end

      it "should be successful" do
        get :index
        response.should be_success
      end
    end
  end

  describe "GET 'new'" do

    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    describe "stories" do

      before(:each) do
        @owner = FactoryGirl.create(:user, :email => 'master@example.com')
        @st0 = FactoryGirl.create(:story,
          :user => @user,
          :owner => @owner,
          :content => "Foo bar"
        )
        @st1 = FactoryGirl.create(:story,
          :user => @user,
          :owner => @owner,
          :content => "Baz quux"
        )
        @st2 = FactoryGirl.create(:story,
          :user => @owner,
          :owner => @user,
          :content => "Lorem ipsum"
        )
      end
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = {
          :name => "",
          :email => "",
          :password => "",
          :password_confirmation => ""
        }
      end

      it "should not create user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = {
          :name => "Key Kosmatov",
          :email => "key@kosmatov.su",
          :password => "foobar",
          :password_confirmation => "foobar"
        }
      end

      it "should create user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should == I18n.t("flash.user.welcome")
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = {
          :email => "",
          :name => "",
          :password => "",
          :password_confirmation => ""
        }
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
    end

    describe "success" do

      before(:each) do
        @attr = {
          :email => "new-mail@example.com",
          :name => "New Name",
          :password => "newpass",
          :password_confirmation => "newpass"
        }
      end

      it "shold change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should == I18n.t("flash.user.updated")
      end
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        wrong_user = FactoryGirl.create(:user, :email => "wrong@example.com")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(user_path(@user))
      end

      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(user_path(@user))
      end
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "as a non-signed-in user" do

      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do

      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        @admin = test_sign_in(FactoryGirl.create(:user,
          :email => "admin@kosmatov.su",
          :admin => true
        ))
      end

      describe "if try destroy self" do

        it "should not destroy" do
          lambda do
            delete :destroy, :id => @admin
          end.should_not change(User, :count)
        end

        it "should have an error message" do
          delete :destroy, :id => @admin
          flash[:error].should == I18n.t("flash.user.error_destroy_self")
        end
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should have flash message" do
        delete :destroy, :id => @user
        flash[:success].should == I18n.t("flash.user.destroyed")
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end
  end
end