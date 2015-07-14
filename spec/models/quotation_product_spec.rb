require 'rails_helper'

RSpec.describe QuotationProduct, type: :model do
  let(:quotation_product) { FactoryGirl.build(:quotation_product) }
  it { expect(quotation_product).to be_valid }
	it { expect(quotation_product).to respond_to(:quotation) }
	it { expect(quotation_product).to respond_to(:product) }
	it "has a valid price" do
	  quotation_product.price = Faker::Lorem.word
	  expect(quotation_product).to_not be_valid
	  quotation_product.price = nil
	  expect(quotation_product).to_not be_valid
	end
	it "has a valid quotation" do
		quotation_product.quotation = nil
		expect(quotation_product).to_not be_valid
	end
	it "has a valid product" do
		quotation_product.product = nil
		expect(quotation_product).to_not be_valid
	end
	it "has a valid name" do
		quotation_product.name = nil
		expect(quotation_product).to_not be_valid
	end
	it "has a valid quantity" do
		quotation_product.quantity = nil
		expect(quotation_product).to_not be_valid
	end
	it "has a quantity greater than 0" do
		quotation_product.quantity = 0
		expect(quotation_product).to_not be_valid
	end
	it "cannot have fractional values" do
		quotation_product.quantity = Faker::Commerce.price
		expect(quotation_product).to_not be_valid
	end
end
