require 'digest'
class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :provider, :uid, :email

	imp_email = /incentivementoringprogram.org$/i

  has_many :reimbursements
	
	validates :email, 
		:presence => true, 
		:format => {:with => imp_email, :message => "Please sign in with given IMP email address."}
	validates :uid, :presence => true
	validates :provider, :presence => true, :inclusion => {:in => ['google_oauth2']}
	validates :first_name, :presence => true
	validates :last_name, :presence => true

	def self.create_with_omniauth(auth)
		create do |user|
			user.provider = auth[:provider]
			user.uid = auth[:uid]
			user.first_name = auth[:info][:first_name]
			user.last_name = auth[:info][:last_name]
			user.email = auth[:info][:email]
		end
	end

	def self.authenticate_with_salt(cookie_id, cookie_salt)
		user = User.find_by_id(cookie_id)
		(user && user.salt == cookie_salt) ? user : nil
	end

	private
		def make_salt(uid)
			self.salt = secure_hash("#{Time.now.utc}--#{uid}")
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdisgest(string)
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

