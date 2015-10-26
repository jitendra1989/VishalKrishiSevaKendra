class OnlineTax < ActiveRecord::Base
	has_ancestry
	validates :name, presence: true
	validates :percentage, numericality: true
end
