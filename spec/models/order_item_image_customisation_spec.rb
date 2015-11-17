require 'rails_helper'

RSpec.describe OrderItemImageCustomisation, type: :model do
	let(:order_item_image_customisation) { FactoryGirl.build(:order_item_image_customisation) }
	let(:user) { FactoryGirl.create(:user) }
	it { expect(order_item_image_customisation).to be_valid }
	it { expect(order_item_image_customisation).to respond_to(:order_item) }
	it { expect(order_item_image_customisation).to respond_to(:characteristic) }
	it { expect(order_item_image_customisation).to respond_to(:characteristic_image) }
	it { expect(order_item_image_customisation).to respond_to(:modifier_id) }
	it { expect(order_item_image_customisation).to respond_to(:user) }
	it "has a valid order_item" do
		order_item_image_customisation.order_item = nil
		expect(order_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic" do
		order_item_image_customisation.characteristic = nil
		expect(order_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic_image" do
		order_item_image_customisation.characteristic_image = nil
		expect(order_item_image_customisation).not_to be_valid
	end

	describe 'logging' do
		before do
			order_item_image_customisation.save
		end
		it 'adds a log entry' do
			order_item_image_customisation.modifier_id = user.id
			expect{
				order_item_image_customisation.save
			}.to change(WorkshopImageLog, :count).by(1)
		end
	end
end
