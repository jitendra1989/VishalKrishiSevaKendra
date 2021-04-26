class CharacteristicImage < ApplicationRecord
  mount_uploader :name, CharacteristicImageUploader
  belongs_to :characteristic
end
