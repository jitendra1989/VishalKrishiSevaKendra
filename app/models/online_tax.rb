class OnlineTax < ApplicationRecord
	has_ancestry
	validates :name, presence: true
	validates :percentage, numericality: true
end
