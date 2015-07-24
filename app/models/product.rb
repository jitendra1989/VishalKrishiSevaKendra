class Product < ActiveRecord::Base
	has_many :product_categories, dependent: :destroy
	has_many :stocks
	has_many :cart_items
	belongs_to :product_type
	has_many :categories, through: :product_categories
	has_many :images, class_name: ProductImage, dependent: :destroy

	[:name, :code, :description, :product_type_id].each { |n| validates n, presence: true }
	validates :price, numericality: true
	accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy:true

	def outlet_stock_quantity(outlet)
		self.stocks.where(outlet: outlet).last.try(:quantity) || 0
	end

	def price_with_taxes
		taxes = self.product_type.taxes.pluck(:percentage)
		tax_amount = 0
		taxes.each { |tax| tax_amount += self.price * tax/100 }
		self.price + tax_amount
	end
end
