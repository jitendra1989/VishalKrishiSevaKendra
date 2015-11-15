class WorkshopLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_item_customisation
end
