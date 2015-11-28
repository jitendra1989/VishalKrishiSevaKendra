class RequirementItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :requirement

  before_validation :add_name

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  private
    def add_name
      self.assign_attributes(self.product.attributes.slice('name')) if self.product
    end
end
