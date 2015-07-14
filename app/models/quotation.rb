class Quotation < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user

  [:discount_amount, :customer_id, :user_id].each { |n| validates n, presence: true }
  validates :discount_amount, numericality: true
end
