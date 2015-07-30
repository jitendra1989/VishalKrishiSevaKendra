class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet
  has_many :receipts, dependent: :destroy
  has_many :items, class: OrderItem, dependent: :destroy

  attr_accessor :cart_id

  [:discount_amount, :customer_id, :user_id, :outlet_id].each { |n| validates n, presence: true }
  validates :discount_amount, numericality: true

  after_initialize :add_customer, if: :new_record?
  after_create :add_cart_items

  private
    def add_customer
      self.customer = Cart.find(self.cart_id).customer if self.cart_id
    end
    def add_cart_items
      if self.cart_id
        cart = Cart.includes(:items).find(self.cart_id)
        cart.items.includes(:product).each do |cart_item|
          self.items.create(product: cart_item.product, quantity: cart_item.quantity)
          stock = self.outlet.product_stock(cart_item.product)
          stock.ordered += cart_item.quantity
          stock.quantity -= cart_item.quantity
          stock.save!
        end
        cart.destroy!
      end
    end

end
