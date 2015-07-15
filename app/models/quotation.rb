class Quotation < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  has_many :products, class_name: QuotationProduct, dependent: :destroy

  accepts_nested_attributes_for :products, reject_if: :all_blank

  [:discount_amount, :customer_id, :user_id].each { |n| validates n, presence: true }
  validates :discount_amount, numericality: true
  validates :products, presence: true, on: :create
end
