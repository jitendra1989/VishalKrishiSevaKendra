class Quotation < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  has_many :products, class_name: "QuotationProduct", dependent: :destroy

  accepts_nested_attributes_for :products, reject_if: :all_blank

  [:discount_amount, :customer_id, :user_id].each { |n| validates n, presence: true }
  validates :discount_amount, numericality: true
  validates :products, presence: true, on: :create
  validate :allowed_discount

  private
    def allowed_discount
      if self.user && self.discount_amount
        total = self.products.map{ |x| x.price * x.quantity }.sum
        allowed_amount = (total * self.user.allowed_discount/100) + 100
        errors.add(:discount_amount, "cannot exceed #{self.user.allowed_discount}%") if self.discount_amount > allowed_amount
      end
    end
end
