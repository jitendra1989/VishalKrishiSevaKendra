class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  has_many :customisations, class_name: "CartItemCustomisation", dependent: :destroy
  has_many :image_customisations, class_name: "CartItemImageCustomisation", dependent: :destroy

  validates :quantity, presence: true, numericality: true

  accepts_nested_attributes_for :customisations, reject_if: :all_blank, allow_destroy:true
  accepts_nested_attributes_for :image_customisations, reject_if: :all_blank, allow_destroy:true

  before_destroy :return_stock

  private
    def return_stock
      if self.product.is_a? ProductGroup
        self.product.group_items.each do |group_item|
          self.cart.outlet.product_stock(group_item.related_product).return_to_stock(group_item.quantity/self.quantity)
        end
      else
        self.cart.outlet.product_stock(self.product).return_to_stock(self.quantity)
      end
    end
end
