class Category < ActiveRecord::Base
  belongs_to :parent, class_name: Category, foreign_key: :parent_id
  has_many :sub_categories, class_name: Category, foreign_key: :parent_id, dependent: :destroy
  validates :name, presence: true
end
