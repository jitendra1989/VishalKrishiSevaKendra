class SalesRelationship < ActiveRecord::Base
  belongs_to :product
  belongs_to :related_product, class_name: Product

  [:product_id, :related_product_id].each { |n| validates n, presence: true }
end
