class OrderTax < ActiveRecord::Base
  belongs_to :order
  validates :name, presence: true
	validates :amount, numericality: true
end
