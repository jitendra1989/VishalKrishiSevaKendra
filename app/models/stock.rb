class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :outlet
  before_create :set_defaults

  store :details, accessors: [ :opening, :in_carts, :ordered, :invoiced, :new_quantity, :code, :online_carts, :supplier_name, :invoice_date, :invoice_number], coder: JSON

  [:product_id, :outlet_id, :code].each { |n| validates n, presence: true }
  [:new_quantity].each { |n| validates n, numericality: true }

  def add_to_cart(product_quantity, cart_id = nil)
    available_quantity = [self.quantity, product_quantity].min
    self.quantity -= available_quantity
    self.in_carts += available_quantity
    store_cart_id(cart_id, available_quantity) if cart_id
    save!
    available_quantity
  end

  def return_to_stock(product_quantity)
    self.quantity += product_quantity
    self.in_carts -= product_quantity
    save
  end

  private
    def set_defaults
      self.opening, self.in_carts, self.ordered, self.invoiced = self.product.outlet_stock_quantity(self.outlet), 0, 0, 0
      self.quantity = self.opening + self.new_quantity.to_i
    end

    def store_cart_id(cart_id, added_quantity)
      self.online_carts ||= {}
      self.online_carts[cart_id] ||= 0
      self.online_carts[cart_id] += added_quantity
    end
end
