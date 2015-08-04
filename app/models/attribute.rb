class Attribute < ActiveRecord::Base
	validates :name, presence: true
end
