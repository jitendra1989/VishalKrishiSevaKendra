class Requirement < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet
  has_many :products, class_name: "RequirementItem", dependent: :destroy

  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true
end
