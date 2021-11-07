class Specification < ApplicationRecord
	UNITS = %w(inches gram)
	has_many :product_specifications, dependent: :destroy

	validates :name, presence: true
	validates :units, inclusion: { in: UNITS }
end
