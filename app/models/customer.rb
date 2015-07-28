class Customer < ActiveRecord::Base
	has_many :quotations
	has_many :carts
	has_many :orders
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	[:name, :mobile, :phone, :address, :pincode, :city, :state, :country].each do |n|
		validates n, presence: true, on: :update
	end

	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	validates :mobile, length: { is: 10 }, on: :update
	validates :pincode, length: { is: 6 }, on: :update

	before_save { self.email.downcase! }

	has_secure_password

	def full_address
		"#{address}, #{city}, #{state} - #{pincode}"
	end

	def activate_cart(user)
		customer_cart = user.outlet.carts.find_by(customer: self)
		unless customer_cart
			customer_cart = user.outlet.carts.find_or_create_by(customer: nil)
			customer_cart.update(user: user, customer: self)
		end
		customer_cart
	end
end
