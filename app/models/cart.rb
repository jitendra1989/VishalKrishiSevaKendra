class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet
  validates :customer_id, uniqueness: { scope: :outlet_id }
end
