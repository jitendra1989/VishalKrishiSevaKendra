class ProductCategory < ActiveRecord::Base
  belongs_to :product
  belongs_to :category

  validates :category_id, presence: true
end
