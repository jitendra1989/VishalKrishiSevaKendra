class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :outlet
  before_create :set_defaults

  store :details, accessors: [ :opening, :in_carts, :ordered, :invoiced, :new_quantity, :code ], coder: JSON

  [:product_id, :outlet_id, :code].each { |n| validates n, presence: true }
  [:new_quantity].each { |n| validates n, numericality: true }

  def add_to_cart(product_quantity)
    available_quantity = [self.quantity, product_quantity].min
    self.quantity -= available_quantity
    self.in_carts += available_quantity
    save
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
end
