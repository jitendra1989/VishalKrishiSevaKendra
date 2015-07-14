class Customer < ActiveRecord::Base
	has_many :quotations
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	[:name, :email, :mobile, :phone, :address, :pincode, :city, :state, :country].each do |n|
		validates n, presence: true
	end

	validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	validates :mobile, length: { is: 10 }
	validates :pincode, length: { is: 6 }

	before_save { self.email.downcase! }
end
