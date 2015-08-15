require 'rails_helper'

RSpec.describe OnlineOrder, type: :model do
  let(:online_order) { FactoryGirl.build(:online_order) }
  let!(:stock) { FactoryGirl.create(:stock, outlet: FactoryGirl.create(:online_outlet)) }
  let(:online_cart) { FactoryGirl.create(:online_cart) }
  let!(:online_tax) { FactoryGirl.create(:online_tax) }
  before do
    online_order.online_cart_id = online_cart.id
    online_cart.add_item(stock.product.id, stock.quantity)
  end

  it { expect(online_order).to be_valid }
  it { expect(online_order).to respond_to(:customer) }
  it { expect(online_order).to respond_to(:items) }
  it { expect(online_order).to respond_to(:taxes) }

  it "has a valid customer" do
    online_order.customer = nil
    expect(online_order).not_to be_valid
  end

  describe 'after online_order creation' do
    it 'adds all cart products to itself' do
      cart_items_count = online_cart.items.size
      expect{
        online_order.save!
      }.to change(OnlineOrderItem, :count).by(cart_items_count)
    end
    it 'destroys the existing cart' do
      expect{
        online_order.save!
      }.to change(OnlineCart, :count).by(-1)
    end
    it 'sends an email to the customer' do
      expect{
        online_order.save!
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
    describe 'subtotal and taxes' do
      let!(:subtotal) { online_cart.items.includes(:product).pluck('sale_price * quantity').sum }
      before do
        online_order.save!
      end
      it 'sets the order subtotal without taxes' do
        expect(online_order.subtotal).to eq(subtotal)
      end
      it 'sets order taxes amount equal to online taxes times subtotal' do
        tax_amount = subtotal * OnlineTax.pluck(:percentage).sum/100
        expect(online_order.tax_amount).to eq(tax_amount)
      end
    end
    describe 'stock control' do
      it 'adds the requested quantity to ordered' do
        online_order.save!
        expect(stock.reload.ordered).to eq(online_order.items.find_by(product: stock.product).quantity)
      end
      it 'subtracts the requested quantity from quantity' do
        stock_quantity = stock.quantity
        online_order.save!
        expect(stock.reload.quantity).to eq(stock_quantity - online_order.items.find_by(product: stock.product).quantity)
      end
    end
    describe 'Order Taxes' do
      it 'creates order tax entries' do
        expect{
          online_order.save!
        }.to change(OnlineOrderTax, :count).by(1)
      end
    end
  end
end
