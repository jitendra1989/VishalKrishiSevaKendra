require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
	let(:product_category) { FactoryGirl.build(:product_category) }
	it { expect(product_category).to be_valid }
	it { expect(product_category).to respond_to(:product) }
	it { expect(product_category).to respond_to(:category) }
	it "has a valid product" do
		product_category.product = nil
		expect(product_category).to_not be_valid
	end
	it "has a valid category" do
		product_category.category = nil
		expect(product_category).to_not be_valid
	end
end
