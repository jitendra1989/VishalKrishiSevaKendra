require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.build(:order) }
  let!(:stock) { FactoryGirl.create(:stock, outlet: order.outlet) }
  let(:cart) { FactoryGirl.create(:cart, outlet: stock.outlet) }

  before do
    stock.product.product_type.taxes << FactoryGirl.create(:tax)
    order.cart_id = cart.id
    cart.add_item(stock.product.id, stock.quantity)
  end
  it { expect(order).to be_valid }
  it { expect(order).to respond_to(:customer) }
  it { expect(order).to respond_to(:user) }
  it { expect(order).to respond_to(:items) }
  it { expect(order).to respond_to(:taxes) }
  it { expect(order).to respond_to(:receipts) }
  it { expect(order).to respond_to(:invoice) }
  it { expect(order).to respond_to(:cart_id) }
  it { expect(order).to respond_to(:flagged_by, :comment) }

  it "has a valid discount amount" do
    order.discount_amount = Faker::Lorem.word
    expect(order).not_to be_valid
    order.discount_amount = nil
    expect(order).not_to be_valid
  end

  it 'has discount equal to or less than user allowed discount' do
    active_cart = Cart.find(order.cart_id)
    total = active_cart.items.first.product.price_with_taxes * active_cart.items.first.quantity
    discount_allowed = cart.user.allowed_discount
    order.discount_amount = (total * discount_allowed/100) + 101
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
    it 'adds all cart products to itself' do
      cart_items_count = cart.items.size
      expect{
        order.save!
      }.to change(OrderItem, :count).by(cart_items_count)
    end
    it 'adds all cart item customisations' do
      cart_items_count = cart.items.size
      expect{
        order.save!
      }.to change(OrderItem, :count).by(cart_items_count)
    end
    it 'adds all cart item customisations' do
      FactoryGirl.create(:cart_item_customisation, cart_item: cart.items.first)
      expect{
        order.save!
      }.to change(OrderItemCustomisation, :count).by(1)
    end
    it 'adds all cart item image customisations' do
      FactoryGirl.create(:cart_item_image_customisation, cart_item: cart.items.first)
      expect{
        order.save!
      }.to change(OrderItemImageCustomisation, :count).by(1)
    end
    describe 'subtotal and taxes' do
      let!(:subtotal) { cart.items.includes(:product).pluck('price * quantity').sum }
      before do
        cart.items.first.product.product_type.taxes << FactoryGirl.create(:tax)
        order.save!
      end
      it 'sets the order subtotal without taxes' do
        expect(order.subtotal).to eq(subtotal)
      end
      it 'sets order taxes amount equal to product taxes times quantity' do
        tax_amount = 0
        order.items.includes(:product).each do |item|
          tax_amount += (item.quantity * item.product.tax_amount(item.product.price))
        end
        expect(order.tax_amount).to eq(tax_amount)
      end
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
  describe 'unpaid amount' do
    before do
      order.save!
    end
    it 'returns the whole order amount if newly placed order' do
      expect(order.unpaid_amount).to eq(order.total)
    end
    it 'returns the whole order amount minus discount minus total of order receipts' do
      FactoryGirl.create_list(:receipt, 2, order: order)
      expect(order.unpaid_amount).to eq(order.total - order.receipts.pluck(:amount).sum)
    end
  end
  describe 'total' do
    before { order.save! }
    it 'returns the whole order amount plus taxes minus discount' do
      total = 0
      order.items.each { |item| total = item.price * item.quantity }
      expect(order.total).to eq(total + order.tax_amount - order.discount_amount)
    end
  end

  describe 'Order Taxes' do
    it 'creates order tax entries' do
      expect{
        order.save!
      }.to change(OrderTax, :count).by(1)
    end
  end
end
