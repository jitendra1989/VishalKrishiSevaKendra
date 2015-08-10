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
	it { expect(product).to respond_to(:sales_relationships) }
	it { expect(product).to respond_to(:cross_sells) }
	it { expect(product).to respond_to(:cross_sale_products) }
	it { expect(product).to respond_to(:product_specifications) }
	it { expect(product).to respond_to(:specifications) }
	it { expect(product).to respond_to(:taxes) }
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
	it "has a valid sale price" do
		product.sale_price = Faker::Lorem.word
		expect(product).to_not be_valid
		product.sale_price = nil
		expect(product).to_not be_valid
	end
	it 'has a sale price smaller than actual price' do
		product.sale_price = product.price * 100
		expect(product).not_to be_valid
	end
	it "has a valid product_type" do
		product.product_type = nil
		expect(product).to_not be_valid
	end
	it "returns all online saleable product" do
		expect(Product.online).to eq(Product.where(saleable_online: true))
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

	describe 'tax_amount and price with taxes' do
		before do
			product.save!
			product.product_type.taxes << FactoryGirl.create_list(:tax, 2)
		end
		it 'returns the the applicable taxes for the product' do
			taxes = product.price * product.product_type.taxes.pluck(:percentage).sum/100
			expect(product.tax_amount).to eq(taxes)
		end
		it 'returns the price plus the applicable taxes for the product' do
			taxes = product.price * product.product_type.taxes.pluck(:percentage).sum/100
			expect(product.price_with_taxes).to eq(product.price + taxes)
		end

		it 'returns the sale price plus the applicable taxes for the product' do
			taxes = product.sale_price * product.product_type.taxes.pluck(:percentage).sum/100
			expect(product.sale_price_with_taxes).to eq(product.sale_price + taxes)
		end
		context 'online taxes' do
			it 'returns the the applicable online taxes for the product' do
				taxes = product.price * OnlineTax.pluck(:percentage).sum/100
				expect(product.online_tax_amount).to eq(taxes)
			end
			it 'returns the price plus the applicable online taxes for the product' do
				taxes = product.price * OnlineTax.pluck(:percentage).sum/100
				expect(product.price_with_online_taxes).to eq(product.price + taxes)
			end
			it 'returns the sale price plus the applicable online taxes for the product' do
				taxes = product.sale_price * OnlineTax.pluck(:percentage).sum/100
				expect(product.sale_price_with_online_taxes).to eq(product.sale_price + taxes)
			end
		end
	end
	describe "online price" do
		context 'without taxes' do
			it 'returns sale_price if greater than 0' do
				expect(product.online_price).to eq(product.sale_price)
			end
			it 'returns price if no sale price listed' do
				product.sale_price = 0
				expect(product.online_price).to eq(product.price)
			end
		end
		context 'with taxes' do
			it 'returns sale_price_with_online_taxes if greater than 0' do
				expect(product.online_price_with_taxes).to eq(product.sale_price_with_online_taxes)
			end
			it 'returns price_with_online_taxes if no sale price listed' do
				product.sale_price = 0
				expect(product.online_price_with_taxes).to eq(product.price_with_online_taxes)
			end
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
	describe 'Add to online cart' do
		let(:stock) { FactoryGirl.build(:stock, product: product, outlet: FactoryGirl.create(:online_outlet)) }
		let(:more_stock) { FactoryGirl.build(:stock, product: product, outlet: FactoryGirl.create(:online_outlet)) }
		let(:cart) { FactoryGirl.create(:online_cart) }
		before do
			product.save!
		end
		it 'returns 0 if no stock present' do
			expect(product.add_to_online_cart(stock.quantity, cart.id)).to eq(0)
		end
		context 'when stock is present' do
			before do
				stock.save!
				more_stock.save!
			end
			it 'adds to cart from all applicable online stores' do
				expect(product.add_to_online_cart(stock.quantity, cart.id)).to eq(stock.quantity)
			end
			it 'adds to cart from all applicable online stores' do
				expect(product.add_to_online_cart(stock.quantity + more_stock.quantity-10, cart.id )).to eq(more_stock.quantity + stock.quantity-10)
			end
			it 'adds to cart only from available stock' do
				expect(product.add_to_online_cart(stock.quantity + more_stock.quantity*10, cart.id )).to eq(more_stock.quantity + stock.quantity)
			end
		end
	end
end
