class Category < ActiveRecord::Base
	has_ancestry
  validates :name, presence: true
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
end
