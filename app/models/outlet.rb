class Outlet < ActiveRecord::Base
	has_many :users
	has_many :stocks
	has_many :carts
	has_many :orders
	[:name, :city, :state, :country].each { |n| validates n, presence: true }

	def product_stock(product)
		self.stocks.where(product: product).last
	end
end
