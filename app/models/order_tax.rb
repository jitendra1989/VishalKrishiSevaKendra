class OrderTax < ApplicationRecord
  belongs_to :order
  validates :name, presence: true
	validates :amount, numericality: true
end
