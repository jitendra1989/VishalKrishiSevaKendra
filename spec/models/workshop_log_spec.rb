require 'rails_helper'

RSpec.describe WorkshopLog, type: :model do
	let(:workshop_log) { FactoryGirl.build(:workshop_log) }
	it { expect(workshop_log).to respond_to(:user) }
	it { expect(workshop_log).to respond_to(:order_item_customisation) }
end
