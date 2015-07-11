class Product < ActiveRecord::Base
	has_many :product_categories, dependent: :destroy
	has_many :categories, through: :product_categories
	has_many :images, class_name: ProductImage, dependent: :destroy

	[:name, :code, :description].each { |n| validates n, presence: true }
	validates :price, numericality: true
	accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy:true
end
