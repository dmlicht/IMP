require 'spec_helper'

describe Reimbursement do
	before(:each) do
		@attr = {
			:title => "Ice Cream",
			:location => "Ice Cream Shop",
			:quantity => "$10",
			:description => "We got ice cream. It was delicious"
		}
	end
  
  it "should be created given valid attributes" do
  	Reimbursement.create!(@attr)
  end 

  describe "#title" do
  	it "should be present" do
  		Reimbursement.new(@attr.merge(:title => "")).should_not be_valid
  	end
  end

  describe "#location" do
  	it "should be present" do
  		Reimbursement.new(@attr.merge(:location => "")).should_not be_valid
  	end
  end

  describe "#quantity" do
  	it "should be present" do
  		Reimbursement.new(@attr.merge(:quantity => "")).should_not be_valid
  	end
  end

  describe "#description" do
  	it "should be present" do
  		Reimbursement.new(@attr.merge(:description => "")).should_not be_valid
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

