class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_ancestry
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_many :banner_categories, dependent: :destroy
  has_many :banners, through: :banner_categories

  validates :name, presence: true
end
