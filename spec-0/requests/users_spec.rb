require 'spec_helper'

describe "Users" do

  describe "sign up" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in :user_name, :with => ""
          fill_in :user_email, :with => ""
          fill_in :user_password, :with => ""
          fill_in :user_password_confirmation, :with => ""
          click_button I18n.t("helpers.submit.user.create")
        end.should_not change(User, :count)
      end
    end

    describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in 'user_name', :with => "Example User"
          fill_in 'user_email', :with => "user@example.com"
          fill_in 'user_password', :with => "foobar"
          fill_in 'user_password_confirmation', :with => "foobar"
          click_button I18n.t('helpers.submit.user.create')
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in/out" do

    describe "failure" do

      it "should not sign a user in" do
        integration_sign_in(User.new)
        page.should have_selector("div.alert-error")
      end
    end

#    describe "success" do

#      it "should sign a user in and out" do
#        user = FactoryGirl.create(:user)
#        integration_sign_in(user)
#        controller.should be_signed_in
#        click_link I18n.t("titles.session.destroy")
#        controller.should_not be_signed_in
#      end
#    end
  end
end
