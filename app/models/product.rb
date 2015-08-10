class Product < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	acts_as_paranoid

	has_many :product_categories, dependent: :destroy
	has_many :stocks
	has_many :cart_items
	belongs_to :product_type
	has_many :categories, through: :product_categories
	has_many :images, class_name: ProductImage, dependent: :destroy
	has_many :sales_relationships, dependent: :destroy
	has_many :cross_sells
	has_many :cross_sale_products, through: :cross_sells, source: :related_product
	has_many :product_specifications
	has_many :specifications, through: :product_specifications, dependent: :destroy

	delegate :taxes, to: :product_type

	[:name, :code, :description, :product_type_id].each { |n| validates n, presence: true }
	[:price, :sale_price].each { |n| validates n, numericality: true }
	validates :sale_price, numericality: { less_than: :price }, if: :price

	scope :online, -> { where(saleable_online: true) }

	accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy:true
	accepts_nested_attributes_for :product_specifications, reject_if: :all_blank, allow_destroy:true

	def outlet_stock_quantity(outlet)
		self.stocks.where(outlet: outlet).last.try(:quantity) || 0
	end

	def tax_amount
		self.price * taxes_on_product
	end

	def price_with_taxes
		self.price + tax_amount
	end

	def sale_price_with_taxes
		self.sale_price + (self.sale_price * taxes_on_product)
	end

	def online_tax_amount
		self.price * online_taxes_on_product
	end

	def price_with_online_taxes
		self.price + (self.price * online_taxes_on_product)
	end

	def sale_price_with_online_taxes
		self.sale_price + (self.sale_price * online_taxes_on_product)
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

	def online_price
		self.sale_price > 0 ? self.sale_price : self.price
	end

	def online_price_with_taxes
		self.sale_price > 0 ? self.sale_price_with_online_taxes : self.price_with_online_taxes
	end
	private
		def taxes_on_product
			ProductType.find(self.product_type_id).taxes.pluck(:percentage).sum/100
		end

		def online_taxes_on_product
			OnlineTax.pluck(:percentage).sum/100
		end
end
