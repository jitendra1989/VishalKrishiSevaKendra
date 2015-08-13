require 'rails_helper'

	RSpec.describe ProductGroup, type: :model do
	let(:product_group) { FactoryGirl.build(:product_group) }
	it { expect(product_group).to be_valid }
	it { expect(product_group).to be_a(ProductGroup) }
	it { expect(product_group).to respond_to(:group_items) }
	it { expect(product_group).to respond_to(:grouped_products) }

	describe 'outlet stock' do
		let(:stock) { FactoryGirl.build(:stock, product: product_group.grouped_products.first) }
		before do
			product_group.save!
		end
		context 'without any stock' do
			it 'returns 0 if group items stock is 0 in the requested outlet' do
				expect(product_group.outlet_stock_quantity(stock.outlet)).to eq(0)
			end
		end
		context 'with partial stock' do
			before { stock.save! }
			it 'returns 0 if any item stock is less than required quantity in requested outlet' do
				expect(product_group.outlet_stock_quantity(stock.outlet)).to eq(0)
			end
		end
		context 'with available stock' do
			let(:stock_multiplier) { (1..5).to_a.sample }
			before do
				product_group.group_items.each do |group_item|
					FactoryGirl.create(:stock, product: group_item.related_product, new_quantity: group_item.quantity * stock_multiplier, outlet: stock.outlet)
				end
			end
			it 'returns the count of stock present in the requested outlet' do
				expect(product_group.outlet_stock_quantity(stock.outlet)).to eq(stock_multiplier)
			end
		end
	end
	describe 'online stock' do
		let(:stock) { FactoryGirl.build(:stock, product: product_group.grouped_products.first, outlet: FactoryGirl.create(:online_outlet)) }
		before do
			product_group.save!
		end
		it 'returns 0 if no stock present' do
			expect(product_group.online_stock).to eq(0)
		end
		context 'with partial stock' do
			before { stock.save! }
			it 'returns 0 if no stock present' do
				expect(product_group.online_stock).to eq(0)
			end
		end
		context 'with available stock' do
			let(:stock_multiplier) { (1..5).to_a.sample }
			before do
				product_group.group_items.each do |group_item|
					FactoryGirl.create(:stock, product: group_item.related_product, new_quantity: group_item.quantity * stock_multiplier, outlet: stock.outlet)
				end
			end
			it 'returns the total of product_group stock for all online stores' do
				expect(product_group.online_stock).to eq(stock_multiplier)
			end
		end
	end
end
