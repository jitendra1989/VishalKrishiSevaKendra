require 'rails_helper'

RSpec.describe OrderItemCustomisation, type: :model do
	let(:order_item_customisation) { FactoryGirl.build(:order_item_customisation) }
	let(:user) { FactoryGirl.create(:user) }
	it { expect(order_item_customisation).to be_valid }
	it { expect(order_item_customisation).to respond_to(:order_item) }
	it { expect(order_item_customisation).to respond_to(:specification) }
	it { expect(order_item_customisation).to respond_to(:modifier_id) }
	it { expect(order_item_customisation).to respond_to(:user) }
	it "has a valid order_item" do
		order_item_customisation.order_item = nil
		expect(order_item_customisation).not_to be_valid
	end
	it "has a valid specification" do
		order_item_customisation.specification = nil
		expect(order_item_customisation).not_to be_valid
	end
	it "has a valid value" do
		order_item_customisation.value = nil
		expect(order_item_customisation).not_to be_valid
	end

	describe 'logging' do
		before do
			order_item_customisation.save!
		end
		it 'adds a log entry' do
			order_item_customisation.modifier_id = user.id
			expect{
				order_item_customisation.save
			}.to change(WorkshopLog, :count).by(1)
		end
	end
end
