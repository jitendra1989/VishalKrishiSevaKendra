class User < ActiveRecord::Base
	belongs_to :outlet
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	[:name, :username, :email, :phone, :address, :pincode, :city, :state, :country].each do |n|
		validates n, presence: true
	end

	validates :username, uniqueness: { case_sensitive: false }
	validates :email, format: { with: VALID_EMAIL_REGEX }
	has_secure_password
end
