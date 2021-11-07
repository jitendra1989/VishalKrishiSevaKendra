class Tax < ApplicationRecord
	has_many :product_type_taxes
	has_many :product_types, through: :product_type_taxes
	validates :name, presence: true
	validates :percentage, numericality: true

end
