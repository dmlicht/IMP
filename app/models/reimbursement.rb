class Reimbursement < ActiveRecord::Base
	attr_accessible :title, :location, :quantity, :description

	belongs_to :user
	
	validates :title, :presence => true
	validates :location, :presence => true
	validates :quantity, :presence => true
	validates :description, :presence => true
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

