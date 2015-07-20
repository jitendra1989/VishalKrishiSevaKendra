class User < ActiveRecord::Base
	belongs_to :outlet
	has_many :quotations
	has_many :user_permissions
	has_many :permissions, through: :user_permissions
	has_many :user_roles
	has_many :roles, through: :user_roles
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	[:name, :username, :email, :phone, :address, :pincode, :city, :state, :country].each do |n|
		validates n, presence: true
	end

	validates :username, uniqueness: { case_sensitive: false }
	validates :email, format: { with: VALID_EMAIL_REGEX }
	validates :pincode, length: { is: 6 }
	has_secure_password
end
