class User < ActiveRecord::Base
	belongs_to :outlet
	has_many :quotations
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	ROLES = %w[super_admin admin sales_executive production_manager]

	scope :admin, -> { where role: ROLES.second }

	[:name, :username, :role, :email, :phone, :address, :pincode, :city, :state, :country].each do |n|
		validates n, presence: true
	end

	validates :username, uniqueness: { case_sensitive: false }
	validates :role, inclusion: ROLES
	validates :email, format: { with: VALID_EMAIL_REGEX }
	validates :pincode, length: { is: 6 }
	has_secure_password

	ROLES.each_with_index do |item, index|
		define_method("#{item}?") { role == ROLES[index] }
	end
end
