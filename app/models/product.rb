class Product < ActiveRecord::Base
	[:name, :code, :description].each { |n| validates n, presence: true }
	validates :price, numericality: true
end
