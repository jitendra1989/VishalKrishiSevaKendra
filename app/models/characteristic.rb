class Characteristic < ActiveRecord::Base

	has_many :images, class_name: CharacteristicImage, dependent: :destroy

	validates :name, presence: true

	accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy:true
end
