class GroupItem < ApplicationRecord
  belongs_to :product
  belongs_to :related_product, class_name: "Product"

  validates :related_product_id, presence: true
  validates :product_id, exclusion: { in: lambda { |s| [s.related_product_id] } }
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
