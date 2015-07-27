class OnlineCart < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class_name: OnlineCartItem
end
