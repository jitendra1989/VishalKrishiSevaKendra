require 'rails_helper'

RSpec.describe Receipt, type: :model do
	let(:order) { FactoryGirl.build(:order) }
	let!(:stock) { FactoryGirl.create(:stock, outlet: order.outlet) }
	let(:cart) { FactoryGirl.create(:cart, outlet: stock.outlet) }
	let(:receipt) { FactoryGirl.build(:receipt, order: order, amount: 1) }
	before do
	  order.cart_id = cart.id
	  cart.add_item(stock.product.id, stock.quantity)
	  order.save!
	end

	it { expect(receipt).to be_valid }
	it { expect(receipt).to respond_to(:user) }
	it { expect(receipt).to respond_to(:order) }
	it { expect(receipt).to respond_to(:payment_method) }
	it "has a valid amount" do
		receipt.amount = Faker::Lorem.word
		expect(receipt).not_to be_valid
		receipt.amount = nil
		expect(receipt).to_not be_valid
		receipt.amount = receipt.order.unpaid_amount * 20
		expect(receipt).to_not be_valid
	end
	it "has a valid user" do
		receipt.user = nil
		expect(receipt).to_not be_valid
	end
	it "has a valid order" do
		receipt.order = nil
		expect(receipt).to_not be_valid
	end
	it "has a payment_method belonging to the PAYMENT_METHODS defined" do
		receipt.payment_method = Faker::Lorem.word
		expect(receipt).not_to be_valid
		receipt.payment_method = nil
		expect(receipt).to_not be_valid
	end
	describe 'cheque payment' do
		before do
			receipt.payment_method = Receipt::PAYMENT_METHODS.keys.second
		end
		it 'has a valid cheque number' do
			receipt.cheque_number = nil
			expect(receipt).to_not be_valid
		end
		it 'has a valid cheque date' do
			receipt.cheque_number = nil
			expect(receipt).to_not be_valid
		end
		it 'has a valid cheque_bank' do
			receipt.cheque_bank = nil
			expect(receipt).to_not be_valid
		end
	end
	describe 'card payment' do
		before do
			receipt.payment_method = [Receipt::PAYMENT_METHODS.keys.third, Receipt::PAYMENT_METHODS.keys.fourth].sample
		end
		it 'has a valid card number' do
			receipt.card_number = nil
			expect(receipt).to_not be_valid
		end
	end
	describe "amount in words" do
		it 'returns a string' do
			expect(receipt.amount_in_words).to be_a(String)
		end
	end
	describe 'RTGS' do
		it { expect(receipt).to respond_to(:utr) }
	end
end
