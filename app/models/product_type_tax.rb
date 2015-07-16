class ProductTypeTax < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :tax
end
