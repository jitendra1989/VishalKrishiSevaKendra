require 'rails_helper'

RSpec.describe QuotationProduct, type: :model do
  let(:quotation_product) { FactoryGirl.build(:quotation_product) }
  it { expect(quotation_product).to be_valid }
	it { expect(quotation_product).to respond_to(:quotation) }
	it { expect(quotation_product).to respond_to(:product) }
	it "has a valid product" do
		quotation_product.product = nil
		expect(quotation_product).to_not be_valid
	end
	describe 'Name and price assignment' do
		before { quotation_product.valid? }
		it 'assigns itself the name of the product' do
			puts quotation_product.product_id
			expect(quotation_product.name).to eq(quotation_product.product.name)
		end
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
