class Characteristic < ActiveRecord::Base
	validates :name, presence: true
end
