class User < ActiveRecord::Base
	include FlagShihTzu

	has_flags 1 => :store_boss,
						2 => :main_boss,
						3 => :developer

	belongs_to :outlet
	has_many :carts
	has_many :quotations
	has_many :orders
	has_many :user_permissions, dependent: :destroy
	has_many :permissions, through: :user_permissions
	has_many :user_roles, dependent: :destroy
	has_many :roles, through: :user_roles
	has_many :receipts, dependent: :destroy
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	scope :regular, -> { where(flags: 0) }

	[:name, :username, :email, :phone, :address, :pincode, :city, :state, :country].each do |n|
		validates n, presence: true
	end

	validates :username, uniqueness: { case_sensitive: false }
	validates :email, format: { with: VALID_EMAIL_REGEX }
	validates :pincode, numericality: true, length: { is: 6 }
	has_secure_password


	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		Admin::UserMailer.password_reset(self).deliver_now
	end

	def regular?
		flags == 0
	end

	def allowed_discount
		regular? ? self.roles.maximum(:discount_percent) || 0 : 100
	end

	private
		def generate_token(column)
			begin
				self[column] = SecureRandom.urlsafe_base64
			end while User.exists?(column => self[column])
		end
end
