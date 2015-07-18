class Product < ActiveRecord::Base
	has_many :product_categories, dependent: :destroy
	has_many :stocks
	belongs_to :product_type
	has_many :categories, through: :product_categories
	has_many :images, class_name: ProductImage, dependent: :destroy

	[:name, :code, :description, :product_type_id].each { |n| validates n, presence: true }
	validates :price, numericality: true
	accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy:true
end
