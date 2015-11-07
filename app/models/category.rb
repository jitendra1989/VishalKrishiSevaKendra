class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_ancestry
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_many :banner_categories, dependent: :destroy
  has_many :banners, through: :banner_categories
  has_many :category_coupons, dependent: :destroy
  has_many :coupon_codes, through: :category_coupons

  validates :name, presence: true
end
