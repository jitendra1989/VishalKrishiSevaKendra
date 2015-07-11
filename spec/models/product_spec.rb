require 'rails_helper'

RSpec.describe Product, type: :model do
	let(:product) { FactoryGirl.build(:product) }
	it { expect(product).to be_valid }
	it { expect(product).to respond_to(:images) }
	it { expect(product).to respond_to(:product_categories) }
	it { expect(product).to respond_to(:categories) }
	it "has a valid name" do
		product.name = nil
		expect(product).to_not be_valid
	end
	it "has a valid code" do
		product.code = nil
		expect(product).to_not be_valid
	end
	it "has a valid description" do
		product.description = nil
		expect(product).to_not be_valid
	end
	it "has a valid price" do
		product.price = Faker::Lorem.word
		expect(product).to_not be_valid
		product.price = nil
		expect(product).to_not be_valid
	end
end
