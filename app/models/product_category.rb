class ProductCategory < ActiveRecord::Base
  belongs_to :product
  belongs_to :category

  [:product_id, :category_id].each { |n| validates n, presence: true }
end
