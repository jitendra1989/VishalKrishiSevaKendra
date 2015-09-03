class Customer < ActiveRecord::Base
	acts_as_paranoid

	has_many :quotations
	has_many :carts
	has_many :orders
	has_many :invoices
	has_one :online_cart
	has_many :online_orders
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	[:name, :mobile, :phone, :address, :pincode, :city, :state, :country].each do |n|
		validates n, presence: true, on: :update
	end

	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	validates :mobile, length: { is: 10 }, on: :update
	validates :pincode, length: { is: 6 }, format: { with: /\A403\d{3}\z/ , message: 'must be based in Goa' }, on: :update

	before_save { self.email.downcase! }
	before_create :send_activation_email

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

	def set_online_cart(online_cart_id)
		if online_cart_id
			session_cart = OnlineCart.find(online_cart_id)
			if self.online_cart
				session_cart.items.each { |item| self.online_cart.items << item }
				session_cart.delete
			else
				self.update(online_cart: session_cart)
			end
		end
		self.online_cart.try(:id)
	end


	def activate
		self.activated = true
		self.activation_digest = nil
		self.activated_at = Time.zone.now
		save validate: false
	end

	private
		def generate_token(column)
			begin
				self[column] = SecureRandom.urlsafe_base64
			end while Customer.exists?(column => self[column])
		end

		def send_activation_email
			generate_token(:activation_digest)
			Front::CustomerMailer.welcome(self).deliver_now
		end
end
