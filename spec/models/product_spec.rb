require 'rails_helper'

RSpec.describe Product, type: :model do
	let(:product) { FactoryGirl.build(:product) }
	it { expect(product).to be_valid }
	it { expect(product).to respond_to(:images) }
	it { expect(product).to respond_to(:product_categories) }
	it { expect(product).to respond_to(:categories) }
	it { expect(product).to respond_to(:product_type) }
	it { expect(product).to respond_to(:stocks) }
	it { expect(product).to respond_to(:cart_items) }
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
	it "has a valid product_type" do
		product.product_type = nil
		expect(product).to_not be_valid
	end
	describe 'outlet stock' do
		let(:stock) { FactoryGirl.build(:stock, product: product) }
		before do
			product.save!
		end
		it 'returns 0 if no stock in the requested outlet' do
			expect(product.outlet_stock_quantity(stock.outlet)).to eq(0)
		end
		it 'returns the count of stock present in the requested outlet' do
			stock.save!
			expect(product.outlet_stock_quantity(stock.outlet)).to eq(stock.quantity)
		end
	end

	describe 'price with taxes' do
		before do
			product.save!
			product.product_type.taxes << FactoryGirl.create_list(:tax, 2)
		end
		it 'returns the price plus the applicable taxes for the product' do
			taxes = product.product_type.taxes.pluck(:percentage)
			tax_amount = 0
			taxes.each { |tax| tax_amount += product.price * tax/100 }
			expect(product.price_with_taxes).to eq(product.price + tax_amount)
		end
	end
	describe 'online stock' do
		let(:stock) { FactoryGirl.build(:stock, product: product, outlet: FactoryGirl.create(:online_outlet)) }
		before do
			product.save!
		end
		it 'returns 0 if no stock present' do
			expect(product.online_stock).to eq(0)
		end
		it 'returns the total of product stock for all online stores' do
			stock.save!
			expect(product.online_stock).to eq(stock.quantity)
		end
	end
end
