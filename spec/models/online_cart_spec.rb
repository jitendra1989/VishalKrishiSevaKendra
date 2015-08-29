require 'rails_helper'

RSpec.describe OnlineCart, type: :model do
  let(:online_cart) { FactoryGirl.create(:online_cart) }
  let(:product) { FactoryGirl.create(:product) }
  let(:quantity) { Faker::Number.digit.to_i }
  let!(:stock) { FactoryGirl.create(:stock, product: product, outlet: FactoryGirl.create(:online_outlet)) }
  it { expect(online_cart).to be_valid }
  it { expect(online_cart).to respond_to(:customer) }
  it { expect(online_cart).to respond_to(:items) }

  describe "Add to cart" do
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
    describe "Update cart" do
      it 'updates product quantity in the cart' do
        online_cart.update_item(product.id, quantity)
        expect(online_cart.items.find_by(product: product).quantity).to eq(quantity)
      end
    end
  end
  describe "Destroy item from cart" do
    before do
      online_cart.update_item(product.id, quantity)
    end
    it 'deletes the item from cart' do
      online_cart.destroy_item(product.id)
      expect(online_cart.items.find_by(product: product)).to be_nil
    end
  end
  describe "check_and_block_stock" do
    it 'checks stock available for each product' do
      online_cart.update_item(product.id, quantity)
      online_cart.check_and_block_stock
      expect(online_cart.items.find_by(product: product).quantity).to eq(quantity)
    end
    it 'updates stock available for each product' do
      large_quantity = quantity*10
      online_cart.update_item(product.id, large_quantity)
      online_cart.check_and_block_stock
      expect(online_cart.items.find_by(product: product).quantity).to eq([stock.quantity, large_quantity].min)
    end
    it 'sets the current timestamp' do
      online_cart.check_and_block_stock
      expect(online_cart.blocked_at).to be_within(0.10).of(Time.zone.now)
    end
  end
end
