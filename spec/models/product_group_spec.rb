require 'rails_helper'

	RSpec.describe ProductGroup, type: :model do
	let(:product_group) { FactoryGirl.build(:product_group) }
	it { expect(product_group).to be_valid }
	it { expect(product_group).to be_a(ProductGroup) }
	it { expect(product_group).to respond_to(:group_items) }
end