class CharacteristicImage < ActiveRecord::Base
  mount_uploader :name, CharacteristicImageUploader
  belongs_to :characteristic
end
