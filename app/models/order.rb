class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet

  [:discount_amount, :customer_id, :user_id, :outlet_id].each { |n| validates n, presence: true }
  validates :discount_amount, numericality: true

end
