require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.build(:order) }
  it { expect(order).to be_valid }
  it { expect(order).to respond_to(:customer) }
  it { expect(order).to respond_to(:user) }
  it { expect(order).to respond_to(:items) }
  it { expect(order).to respond_to(:cart_id) }

  it "has a valid discount amount" do
    order.discount_amount = Faker::Lorem.word
    expect(order).not_to be_valid
    order.discount_amount = nil
    expect(order).not_to be_valid
  end
  it "has a valid customer" do
    order.customer = nil
    expect(order).not_to be_valid
  end
  it "has a valid user" do
    order.user = nil
    expect(order).not_to be_valid
  end
  it "has a valid outlet" do
    order.outlet = nil
    expect(order).not_to be_valid
  end

  describe 'after order creation' do
    let!(:stock) { FactoryGirl.create(:stock, outlet: order.outlet) }
    let(:cart) { FactoryGirl.create(:cart, outlet: stock.outlet) }
    before do
      order.cart_id = cart.id
      cart.add_item(stock.product.id, stock.quantity)
    end
    it 'adds all cart products to itself' do
      cart_items_count = cart.items.size
      expect{
        order.save!
      }.to change(OrderItem, :count).by(cart_items_count)
    end
    it 'destroys the existing cart' do
      expect{
        order.save!
      }.to change(Cart, :count).by(-1)
    end
    describe 'stock control' do
      it 'adds the requested quantity to ordered' do
        order.save!
        expect(stock.reload.ordered).to eq(order.items.find_by(product: stock.product).quantity)
      end
      it 'subtracts the requested quantity from quantity' do
        stock_quantity = stock.quantity
        order.save!
        expect(stock.reload.quantity).to eq(stock_quantity - order.items.find_by(product: stock.product).quantity)
      end
    end
  end
end
