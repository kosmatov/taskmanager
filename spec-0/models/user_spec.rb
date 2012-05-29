require 'spec_helper'

describe User do

	before(:each) do
		@attr = {
			:name => "Example User",
			:email => "user@example.com",
			:password => "foobar",
			:password_confirmation => "foobar"
		}
	end

	it "should create a new instance given valid attributes" do
		User.create!(@attr)
	end

	it "should require a name" do
		User.new(@attr.merge(:name => "")).should_not be_valid
	end

	it "should require a email" do
		User.new(@attr.merge(:email => "")).should_not be_valid
	end

	it "should reject names that are too long" do
		User.new(@attr.merge(:name => "a" * 51)).should_not be_valid
	end

	it "should accept valid email addresses" do
		adrs = %w[user@example.com THE_US-ER@exa-mple.ru.net us.er23@example.jp]
		adrs.each do |addr|
			User.new(@attr.merge(:email => addr)).should be_valid
		end
	end

	it "should reject invalid email addresses" do
		adrs = %w[user@example,com user_at_foo.org example.user@foo.]
		adrs.each do |addr|
			User.new(@attr.merge(:email => addr)).should_not be_valid
		end
	end

	it "should reject dublicate email addresses" do
		User.create!(@attr)
		User.new(@attr).should_not be_valid
	end

	it "should reject email addresses identical up to case" do
		User.create!(@attr.merge(:email => @attr[:email].upcase))
		User.new(@attr).should_not be_valid
	end

	describe "password validations" do

		it "should require a passwords" do
			User.new(@attr.merge(
				:password_confirmation => "invalid"
			)).should_not be_valid
		end
	end

	describe "password encryption" do

		before(:each) do
			@user = User.create!(@attr)
		end

		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end

		it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
		end

		describe "has_password? method" do

			it "should be true if the passwords match" do
				@user.has_password?(@attr[:password]).should be_true
			end

			it "should be false if the passwords don't match" do
				@user.has_password?("invalid").should be_false
			end
		end

		describe "authenticate method" do

			it "should return nil on email/password mismatch" do
				User.authenticate(@attr[:email], "wrongpass").
					should be_nil
			end

			it "should return nil for an email address with no user" do
				User.authenticate("foo@bar.nil", @attr[:password]).
					should be_nil
			end

			it "should return the user on email/password match" do
				User.authenticate(@attr[:email], @attr[:password]).
					should == @user
			end
		end
	end

	describe "admin attribute" do

		before(:each) do
			@user = User.create!(@attr)
		end

		it "should respond to admin" do
			@user.should respond_to(:admin)
		end

		it "should not be an admin by default" do
			@user.should_not be_admin
		end

		it "should be convertible to an admin" do
			@user.toggle!(:admin)
			@user.should be_admin
		end
	end

  describe "stories associations" do

    before(:each) do
      @user = User.create(@attr)
      @owner = User.create(@attr.merge(:email => "owner@example.com"))
      @st0 = FactoryGirl.create(:story, :user => @user, :owner => @owner, :created_at => 1.day.ago)
      @st1 = FactoryGirl.create(:story, :user => @user, :owner => @owner, :created_at => 1.hour.ago)
      @st2 = FactoryGirl.create(:story, :user => @owner, :owner => @user)
    end

    it "should have a outstories attribute" do
      @user.should respond_to(:outstories)
    end

    it "should have a instories attribute" do
      @user.should respond_to(:instories)
    end

    it "should destroy associated stories" do
      @owner.destroy
      [@st0, @st1].each do |story|
        Story.find_by_id(story.id).should be_nil
      end
    end

    it "should have the right in stories" do
      @user.stories(1, :in).should == [@st1, @st0]
    end

    it "should have the right out stories" do
      @user.stories(1, :out).should == [@st2]
    end

    it "should have the right stories filtered by state='accepted'" do
      @st0.state_event = :accepting
      @st0.save
      @owner.stories(1, :all, :accepted).should == [@st0]
    end

    it "should have the right out stories filtered by state='new'" do
      @st0.state_event = :accepting
      @st0.save
      @owner.stories(1, :out, :new).should == [@st1]
    end
  end
end
