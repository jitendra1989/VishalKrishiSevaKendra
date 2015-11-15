class WorkshopImageLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_item_image_customisation
end
