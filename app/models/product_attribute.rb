class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  belongs_to :attribute_list, class_name: Attribute, foreign_key: :attribute_id
  [:product_id, :attribute_id, :value].each{ |n| validates n, presence: true }
end
