class ProductTypeTax < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :tax
  has_ancestry
end
