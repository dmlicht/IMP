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
    context "given valid id and salt from cookie" do
    end

    context "given invalid credentials" do
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

