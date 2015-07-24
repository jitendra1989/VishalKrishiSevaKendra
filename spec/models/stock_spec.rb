require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:stock) { FactoryGirl.build(:stock) }
  it { expect(stock).to be_valid }
  it { expect(stock).to respond_to(:product) }
  it { expect(stock).to respond_to(:outlet) }
  it { expect(stock).to respond_to(:opening) }
  it { expect(stock).to respond_to(:new_quantity) }
  it { expect(stock).to respond_to(:ordered) }
  it { expect(stock).to respond_to(:in_carts) }
  it { expect(stock).to respond_to(:invoiced) }
  it "has a valid product" do
    stock.product = nil
    expect(stock).to_not be_valid
  end
  it "has a valid outlet" do
    stock.outlet = nil
    expect(stock).to_not be_valid
  end
  it "has a valid new_quantity" do
    stock.new_quantity = Faker::Lorem.word
    expect(stock).to_not be_valid
    stock.new_quantity = nil
    expect(stock).to_not be_valid
  end
  it "has a valid code" do
    stock.code = nil
    expect(stock).to_not be_valid
  end

  describe 'on addition of new items' do
    let(:initial_stock) { FactoryGirl.create(:stock) }
    it 'has opening amount of zero' do
      expect(initial_stock.opening).to eq 0
      expect(initial_stock.in_carts).to eq 0
      expect(initial_stock.ordered).to eq 0
      expect(initial_stock.invoiced).to eq 0
    end
    it 'adds the new quantity plus opening to quantity' do
      expect(initial_stock.quantity).to eq(initial_stock.opening + initial_stock.new_quantity)
    end
    it { expect(initial_stock).to be_valid }
    describe 'on addition of more stock' do
      let(:new_stock) { FactoryGirl.create(:stock, product: initial_stock.product, outlet: initial_stock.outlet) }
      it 'has the previous stock as opening' do
        expect(new_stock.opening).to eq (initial_stock.quantity)
      end
    end
    describe 'Add to cart' do
      it 'adds the requested quantity to in_carts' do
        added_quantity = initial_stock.quantity
        initial_stock.add_to_cart(added_quantity)
        expect(initial_stock.reload.in_carts).to eq(added_quantity)
      end
      it 'subtracts the requested quantity from stock quantity' do
        initial_quantity = initial_stock.quantity
        added_quantity = initial_stock.add_to_cart(initial_quantity)
        expect(initial_stock.reload.quantity).to eq(initial_quantity - added_quantity)
      end
      it 'adds only available quantity' do
        added_quantity = initial_stock.quantity
        initial_stock.add_to_cart(added_quantity*10)
        expect(initial_stock.reload.in_carts).to eq(added_quantity)
      end
      it 'returns the available quantity to be added to cart' do
        added_quantity = initial_stock.quantity/3
        expect(initial_stock.add_to_cart(added_quantity)).to eq(added_quantity)
        expect(initial_stock.add_to_cart(1)).to eq(1)
      end
    end
  end
end
