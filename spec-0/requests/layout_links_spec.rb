require 'spec_helper'

describe "LayoutLinks" do

  describe "GET /layout_links" do
    it "should have a signup page at '/signup'" do
      visit '/signup'
      page.should have_content(I18n.t("titles.user.new"))
    end
  end

  describe "GET /" do

    it "should have right links" do
      visit root_path
      click_link I18n.t("titles.page.try")
      page.should have_content(I18n.t("titles.user.new"))
    end
  end

  describe "when not signed in" do

    it "should have a sign in link" do
      visit root_path
      page.should have_content(I18n.t("titles.session.new"))
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in 'session_email', :with => @user.email
      fill_in 'session_password', :with => @user.password
      click_button I18n.t('helpers.submit.session.create')
    end

    it "should have a signout link" do
      visit root_path
      page.should have_content(I18n.t("titles.session.destroy"))
    end

    it "should have an edit link" do
      visit root_path
      page.should have_selector('a[href="' + edit_user_path(@user) + '"]')
    end

    it "should have a user link" do
      visit root_path
      page.should have_selector('a[href="' + user_path(@user) + '"]')
    end
  end
end
