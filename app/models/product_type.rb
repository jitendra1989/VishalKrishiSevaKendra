class ProductType < ActiveRecord::Base
	has_many :product_type_taxes
	has_many :products
	has_many :taxes, through: :product_type_taxes
	validates :name, presence: true
end
