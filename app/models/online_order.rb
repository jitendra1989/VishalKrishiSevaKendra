class OnlineOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class: OnlineOrderItem, dependent: :destroy
end
