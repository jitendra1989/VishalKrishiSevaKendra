require 'rails_helper'

RSpec.describe WorkshopImageLog, type: :model do
	let(:workshop_image_log) { FactoryGirl.build(:workshop_image_log) }
	it { expect(workshop_image_log).to respond_to(:user) }
	it { expect(workshop_image_log).to respond_to(:order_item_image_customisation) }
end
