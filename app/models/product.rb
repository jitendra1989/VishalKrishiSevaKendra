class Product < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :product_categories, dependent: :destroy
	has_many :stocks
	has_many :cart_items
	belongs_to :product_type
	has_many :categories, through: :product_categories
	has_many :images, class_name: ProductImage, dependent: :destroy

	[:name, :code, :description, :product_type_id].each { |n| validates n, presence: true }
	[:price, :sale_price].each { |n| validates n, numericality: true }
	validates :sale_price, numericality: { less_than: :price }, if: :price


	accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy:true

	def outlet_stock_quantity(outlet)
		self.stocks.where(outlet: outlet).last.try(:quantity) || 0
	end

	def tax_amount
		taxes = ProductType.find(self.product_type_id).taxes.pluck(:percentage).sum
		self.price * taxes/100
	end

	def price_with_taxes
		self.price + tax_amount
	end

	def online_stock
		self.stocks.select(:quantity).where(outlet: Outlet.online_outlets.ids).group('outlet_id desc').map(&:quantity).inject(:+) || 0
	end

	def add_to_online_cart(quantity, cart_id)
		if online_stock > 0
			total_added_quantity = 0
			self.stocks.where(outlet: Outlet.online_outlets.ids).group('outlet_id desc').each do |stock|
				added_quantity = stock.add_to_cart(quantity, cart_id)
				total_added_quantity += added_quantity
				quantity -= added_quantity
				break if quantity <= 0
			end
			total_added_quantity
		else
			0
		end
	end
end
