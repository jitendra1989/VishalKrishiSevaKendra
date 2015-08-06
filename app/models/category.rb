class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_ancestry
  validates :name, presence: true
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
end
