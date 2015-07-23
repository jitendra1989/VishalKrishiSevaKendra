class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :outlet
  before_create :set_defaults

  store :details, accessors: [ :opening, :ordered, :invoiced, :new_quantity, :code ], coder: JSON

  [:product_id, :outlet_id, :code].each { |n| validates n, presence: true }
  [:new_quantity].each { |n| validates n, numericality: true }

  private
    def set_defaults
      self.opening, self.ordered, self.invoiced = self.product.outlet_stock_quantity(self.outlet), 0, 0
      self.quantity = self.opening + self.new_quantity.to_i
    end
end
