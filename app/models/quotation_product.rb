class QuotationProduct < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :product

  [:quotation_id, :product_id, :name].each { |n| validates n, presence: true }

  validates :price, numericality: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }
end
