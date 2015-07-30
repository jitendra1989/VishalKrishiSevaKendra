class Receipt < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  [:order_id, :user_id].each { |n| validates n, presence: true }
  validates :amount, numericality: true
end
