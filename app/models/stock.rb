class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :outlet
  store :details, accessors: [ :opening, :ordered, :invoiced, :new_quantity, :code ], coder: JSON

  [:product_id, :outlet_id, :code].each { |n| validates n, presence: true }
  [:quantity, :opening, :ordered, :invoiced, :new_quantity].each { |n| validates n, numericality: true }
end
