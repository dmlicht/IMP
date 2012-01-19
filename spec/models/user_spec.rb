require 'spec_helper'

describe User do
  before(:each) do
  	@attr = {
  		:uid => "22222222222222272222",
  		:provider => "google_oauth2",
  		:first_name => "First",
  		:last_name => "Last",
  		:email => "First.Last@incentivementoringprogram.org"
  	}
  end

  it "is created given valid attributes" do
  	User.create!(@attr)
  end

  describe "#uid" do
  	it "is present" do
  		User.new(@attr.merge(:uid => "")).should_not be_valid
  	end
  end

  describe "#provider" do
  	it "is present" do
  		User.new(@attr.merge(:provider => "")).should_not be_valid
  	end

  	it "is google_oauth2" do
  		User.new(@attr.merge(:provider => "twitter")).should_not be_valid
  	end
  end

  describe "#first_name" do
  	it "is present" do
  		User.new(@attr.merge(:first_name => "")).should_not be_valid
  	end
  end

  describe "#last_name" do
  	it "is present" do
  		User.new(@attr.merge(:last_name => "")).should_not be_valid
  	end
  end

  describe "#email" do
  	it "is present" do
  		User.new(@attr.merge(:email => "")).should_not be_valid
  	end

  	it "ends in @incentivementoringprogram.org" do
  		User.new(@attr.merge(:email => "first.last@aol.com")).should_not be_valid
  	end
  end

  describe ".create_with_omniauth" do
    before(:each) do
      @auth = {
        :uid => "22222222222222272222",
        :provider => "google_oauth2",
        :info => {
          :first_name => "First",
          :last_name => "Last",
          :email => "First.Last@incentivementoringprogram.org"
        }
      }
    end

    context "given valid parameters" do
      it "creates a valid user" do
        User.create_with_omniauth(@auth).should be_valid
      end
    end

    context "given invalid parameters" do
      it "Does not create a valid user" do
        bad_auth = @auth.merge(:info => {:first_name => ""})
        User.create_with_omniauth(bad_auth).should_not be_valid
      end
    end
  end

  describe ".authenticate_with_salt" do
    before(:each) do
      @user = User.create!(@attr)
    end

    context "given valid id and salt from cookie" do
      it "returns a user" do
        User.authenticate_with_salt(@user.id, @user.salt).should == @user
      end
    end

    context "given invalid credentials" do
      it "returns nil" do
        User.authenticate_with_salt('13829389', '2178316716').should be_nil
      end
    end
  end

  describe ".reimbursements" do
    before(:each) do
      @user = User.create!(@attr)
      @reim1 = Factory(:reimbursement, :user => @user, :created_at => 20.years.ago, :title => "murr")
      @reim2 = Factory(:reimbursement, :user => @user, :created_at => 5.minutes.ago, :title => "aight")
    end

    it "is a working method" do
      @user.should respond_to(:reimbursements)
    end

    it "returns reimbursements in the correct order" do
      @user.reimbursements.should == [@reim2, @reim1]
    end
  end
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  uid        :string(255)
#  provider   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  salt       :string(255)
#

