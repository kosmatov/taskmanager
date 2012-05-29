require 'spec_helper'

describe "Stories" do

  before(:each) do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user, :email => "other@example.com")
    visit signin_path
    fill_in 'session_email', :with => @owner.email
    fill_in 'session_password', :with => @owner.password
    click_button I18n.t("helpers.submit.session.create")
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new story" do
        lambda do
          visit user_path(@user)
          click_button I18n.t("helpers.submit.story.create")
          page.should have_selector("div.alert-error")
        end.should_not change(Story, :count)
      end
    end

    describe "success" do

      it "should make a new story" do
        content = "Foo bar"
        lambda do
          visit user_path(@user)
          fill_in 'story_content', :with => content
          select @user.name
          click_button I18n.t("helpers.submit.story.create")
          page.should have_content(content)
        end.should change(Story, :count).by(1)
      end
    end
  end
end
