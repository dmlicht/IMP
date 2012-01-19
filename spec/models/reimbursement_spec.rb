require 'spec_helper'

describe Reimbursement do
	before(:each) do
    @user = Factory(:user)
		@attr = {
			:title => "Ice Cream",
			:location => "Ice Cream Shop",
			:quantity => "$10",
			:description => "We got ice cream. It was delicious"
		}
	end
  
  it "should be created given valid attributes" do
  	@user.reimbursements.create!(@attr)
  end

  describe "#user_id" do
    it "should be present" do
      Reimbursement.new(@attr).should_not be_valid
    end
  end

  describe "#title" do
  	it "should be present" do
  		@user.reimbursements.build(@attr.merge(:title => "")).should_not be_valid
  	end
  end

  describe "#location" do
  	it "should be present" do
  		@user.reimbursements.build(@attr.merge(:location => "")).should_not be_valid
  	end
  end

  describe "#quantity" do
  	it "should be present" do
  		@user.reimbursements.build(@attr.merge(:quantity => "")).should_not be_valid
  	end
  end

  describe "#description" do
  	it "should be present" do
  		@user.reimbursements.build(@attr.merge(:description => "")).should_not be_valid
  	end
  end	

  describe '.user' do
    before(:each) do
      @reimbursement = @user.reimbursements.create!(@attr)
    end

    it "should be recognized" do
      @reimbursement.should respond_to(:user)
    end

    it "should associate the correct user" do
      @reimbursement.user_id.should == @user.id
    end
  end
end
# == Schema Information
#
# Table name: reimbursements
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  location    :string(255)
#  quantity    :string(255)
#  description :string(255)
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

