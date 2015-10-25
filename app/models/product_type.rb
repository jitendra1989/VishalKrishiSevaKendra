class ProductType < ActiveRecord::Base
	has_many :product_type_taxes, -> { order 'ancestry' }
	has_many :products
	has_many :taxes, through: :product_type_taxes
	validates :name, presence: true

	accepts_nested_attributes_for :product_type_taxes, allow_destroy:true, reject_if: proc { |a| a['tax_id'].blank? }
end
