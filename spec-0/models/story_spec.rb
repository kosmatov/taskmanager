require 'spec_helper'

describe Story do

  before(:each) do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user, :email => "user@example.com")
    @attr = {
      :content => "value for content",
      :user_id => @user.id
    }
  end

  it "should create a new instance given valid attributes" do
    @owner.outstories.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @story = @owner.outstories.create(@attr)
    end

    it "should have an owner attribute" do
      @story.should respond_to(:owner)
    end

    it "should have an user attribute" do
      @story.should respond_to(:user)
    end

    it "should have the right associated owner" do
      @story.owner_id.should == @owner.id
      @story.owner.should == @owner
    end

    it "should have the right associated user" do
      @story.user_id.should == @user.id
      @story.user.should == @user
    end
  end

  describe "validations" do

    it "should require an owner id" do
      Story.new(@attr).should_not be_valid
    end

    it "should require non-blank content" do
      @owner.outstories.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @owner.outstories.build(:content => "a" * 256).should_not be_valid
    end
  end
end
