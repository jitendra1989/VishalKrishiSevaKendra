require 'rails_helper'

RSpec.describe OnlineCart, type: :model do
  let(:online_cart) { FactoryGirl.create(:online_cart) }
  it { expect(online_cart).to be_valid }
  it { expect(online_cart).to respond_to(:customer) }
  it { expect(online_cart).to respond_to(:items) }

  describe "Add to cart" do
    let(:product) { FactoryGirl.create(:product) }
    let(:quantity) { Faker::Number.digit.to_i }
    let!(:stock) { FactoryGirl.create(:stock, product: product, outlet: FactoryGirl.create(:online_outlet)) }
    let!(:more_stock) { FactoryGirl.create(:stock, product: product, outlet: FactoryGirl.create(:online_outlet)) }
    it 'adds product to the cart' do
      expect{
        online_cart.add_item(product.id, quantity)
        }.to change(OnlineCartItem, :count).by(1)
    end
    it 'adds product quantity to the cart' do
      online_cart.add_item(product.id, quantity)
      expect(online_cart.items.find_by(product: product).quantity).to be >= quantity
    end
    it 'adds only available product stock if outlet stock is less than requested quantity' do
      previous_quantity = online_cart.items.find_by(product: product).try(:quantity) || 0
      available_quantity = product.online_stock
      requested_quantity = stock.quantity*100
      online_cart.add_item(product.id, requested_quantity)
      expect(online_cart.items.find_by(product: product).quantity).to eq(previous_quantity + [requested_quantity, available_quantity].min)
    end
    describe "Update cart" do
      it 'updates product quantity in the cart' do
        online_cart.update_item(product.id, quantity)
        expect(online_cart.items.find_by(product: product).quantity).to eq(quantity)
      end
    end
    describe "Destroy item from cart" do
      before do
        online_cart.update_item(product.id, quantity)
      end
      it 'restores the product quantity to the stock' do
        stock_before_deletion = product.online_stock
        online_cart.destroy_item(product.id)
        expect(product.reload.online_stock).to eq(stock_before_deletion + quantity)
      end
      it 'deletes the item from cart' do
        online_cart.destroy_item(product.id)
        expect(online_cart.items.find_by(product: product)).to be_nil
      end
    end
  end
end
