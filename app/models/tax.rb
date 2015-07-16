class Tax < ActiveRecord::Base
	validates :name, presence: true
	validates :percentage, numericality: true

end
