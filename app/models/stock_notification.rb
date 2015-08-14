class StockNotification < ActiveRecord::Base
  belongs_to :customer
  belongs_to :product

  [:customer_id, :product_id].each { |n| validates n, presence: true }
  validates :customer_id, uniqueness: { scope: :product_id }
end
