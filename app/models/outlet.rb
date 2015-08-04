class Outlet < ActiveRecord::Base
	acts_as_paranoid

	has_many :users
	has_many :stocks
	has_many :carts
	has_many :orders
	[:name, :city, :state, :country].each { |n| validates n, presence: true }

	scope :online_outlets, -> { where(online_store: true) }

	def product_stock(product)
		self.stocks.where(product: product).last
	end
end
