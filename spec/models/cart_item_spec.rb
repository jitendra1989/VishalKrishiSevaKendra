require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart_item) { FactoryGirl.build(:cart_item) }
  it { expect(cart_item).to be_valid }
  it { expect(cart_item).to respond_to(:product) }
  it { expect(cart_item).to respond_to(:cart) }
  it { expect(cart_item).to respond_to(:customisations) }
  it "has a valid quantity" do
    cart_item.quantity = Faker::Lorem.word
    expect(cart_item).to_not be_valid
    cart_item.quantity = nil
    expect(cart_item).to_not be_valid
  end
  describe 'on destroy' do
    let(:product_stock) { cart_item.cart.outlet.product_stock(cart_item.product) }
    before do
      stock = FactoryGirl.create(:stock, product: cart_item.product, outlet: cart_item.cart.outlet)
      cart_item.save!
      cart_item.cart.add_item(cart_item.product, stock.quantity)
      cart_item.reload
    end
    it "returns the quantity to the stock" do
      available_quantity = product_stock.quantity
      cart_item_quantity = cart_item.quantity
      cart_item.destroy
      expect(product_stock.reload.quantity).to eq(available_quantity + cart_item_quantity)
    end
  end
end
