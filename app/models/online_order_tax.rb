class OnlineOrderTax < ApplicationRecord
  belongs_to :order, class_name: "OnlineOrder", foreign_key: :online_order_id
  validates :name, presence: true
  validates :amount, numericality: true
end
