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

  it "should create given valid attributes" do
  	User.create!(@attr)
  end

  describe "#uid" do
  	it "should be present" do
  		User.new(@attr.merge(:uid => "")).should_not be_valid
  	end
  end

  describe "#provider" do
  	it "should be present" do
  		User.new(@attr.merge(:provider => "")).should_not be_valid
  	end

  	it "should be google_oauth2" do
  		User.new(@attr.merge(:provider => "twitter")).should_not be_valid
  	end
  end

  describe "#first_name" do
  	it "should be present" do
  		User.new(@attr.merge(:first_name => "")).should_not be_valid
  	end
  end

  describe "#last_name" do
  	it "should be present" do
  		User.new(@attr.merge(:last_name => "")).should_not be_valid
  	end
  end

  describe "#email" do
  	it "should be present" do
  		User.new(@attr.merge(:email => "")).should_not be_valid
  	end

  	it "should be @incentivementoringprogram.org" do
  		User.new(@attr.merge(:email => "first.last@aol.com")).should_not be_valid
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

