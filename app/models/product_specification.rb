class ProductSpecification < ApplicationRecord
  belongs_to :product
  belongs_to :specification
  [:product_id, :specification_id, :value].each{ |n| validates n, presence: true }
end
