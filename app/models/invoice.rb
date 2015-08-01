class Invoice < ActiveRecord::Base
  belongs_to :customer
  has_many :orders
  validates :customer_id, :orders, presence: true

  after_create :add_amount

  private
    def add_amount
      self.amount = 0
      self.orders.pluck(:subtotal, :tax_amount, :discount_amount).each do |order|
        self.amount += order[0] + order[1] - order[2]
      end
      save!
    end
end
