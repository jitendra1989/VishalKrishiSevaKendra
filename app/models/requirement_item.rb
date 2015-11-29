class RequirementItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :requirement

  has_many :customisations, class_name: RequirementItemCustomisation, dependent: :destroy
  has_many :image_customisations, class_name: RequirementItemImageCustomisation, dependent: :destroy


  accepts_nested_attributes_for :customisations, reject_if: :all_blank, allow_destroy:true
  accepts_nested_attributes_for :image_customisations, reject_if: :all_blank, allow_destroy:true



  before_validation :add_name

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  private
    def add_name
      self.assign_attributes(self.product.attributes.slice('name')) if self.product
    end
end
