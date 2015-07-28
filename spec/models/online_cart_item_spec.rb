require 'rails_helper'

RSpec.describe OnlineCartItem, type: :model do
  let(:cart_item) { FactoryGirl.create(:online_cart_item) }
  it { expect(cart_item).to be_valid }
  it { expect(cart_item).to respond_to(:product) }
  it { expect(cart_item).to respond_to(:cart) }
  it "has a valid quantity" do
    cart_item.quantity = Faker::Lorem.word
    expect(cart_item).not_to be_valid
    cart_item.quantity = nil
    expect(cart_item).not_to be_valid
  end
  describe 'on destroy' do
    let(:stock){ FactoryGirl.create(:stock, product: cart_item.product, outlet: FactoryGirl.create(:online_outlet)) }
    let(:more_stock){ FactoryGirl.create(:stock, product: cart_item.product, outlet: FactoryGirl.create(:online_outlet)) }
    before do
      cart_item.save!
      cart_item.cart.add_item(cart_item.product, stock.quantity + more_stock.quantity)
      cart_item.reload
    end
    it "returns the quantity to the stock" do
      available_quantity = cart_item.product.online_stock
      cart_item_quantity = cart_item.quantity
      cart_item.destroy
      expect(cart_item.product.reload.online_stock).to eq(available_quantity + cart_item_quantity)
    end
  end
end