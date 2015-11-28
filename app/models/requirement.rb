class Requirement < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet
  has_many :items, class: RequirementItem, dependent: :destroy
end
