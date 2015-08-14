require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { FactoryGirl.create(:cart) }
  it { expect(cart).to be_valid }
  it { expect(cart).to respond_to(:customer) }
  it { expect(cart).to respond_to(:user) }
  it { expect(cart).to respond_to(:outlet) }
  it { expect(cart).to respond_to(:items) }

  it 'belongs to an outlet' do
    cart.outlet = nil
    expect(cart).not_to be_valid
  end

  describe "per customer per outlet" do
    let(:duplicate_cart) { FactoryGirl.build(:cart, customer: cart.customer, outlet: cart.outlet) }
    let(:new_outlet_cart) { FactoryGirl.build(:cart, customer: cart.customer) }
    it { expect(duplicate_cart).to_not be_valid }
    it { expect(new_outlet_cart).to be_valid }
  end
  describe "Add to cart" do
    let(:product) { FactoryGirl.create(:product) }
    let(:quantity) { (1..5).to_a.sample }
    let!(:product_stock) { FactoryGirl.create(:stock, product: product, outlet: cart.outlet) }
    it 'adds product to the cart' do
      expect{
        cart.add_item(product.id, quantity)
        }.to change(CartItem, :count).by(1)
    end
    it 'adds product quantity to the cart' do
      cart.add_item(product.id, quantity)
      expect(cart.items.find_by(product: product).quantity).to be >= quantity
    end
    it 'adds only available product stock if outlet stock is less than requested quantity' do
      previous_quantity = cart.items.find_by(product: product).try(:quantity) || 0
      cart.add_item(product.id, product_stock.quantity*100)
      expect(cart.items.find_by(product: product).quantity).to eq(previous_quantity + product_stock.try(:quantity).to_i)
    end
    describe "Update cart" do
      it 'updates product quantity in the cart' do
        cart.update_item(product.id, quantity)
        expect(cart.items.find_by(product: product).quantity).to eq(quantity)
      end
    end
    describe "Destroy item from cart" do
      before do
        cart.update_item(product.id, quantity)
      end
      it 'restores the product quantity to the stock' do
        stock_before_deletion = cart.outlet.product_stock(product).quantity
        cart.destroy_item(product.id)
        expect(cart.outlet.product_stock(product).quantity).to eq(stock_before_deletion + quantity)
      end
      it 'deletes the item from cart' do
        cart.destroy_item(product.id)
        expect(cart.items.find_by(product: product)).to be_nil
      end
    end
    describe "Add Product Group cart" do
      let(:product_group) { FactoryGirl.build(:product_group) }
      let(:stock_multiplier) { (1..5).to_a.sample }
      let(:product_group_stock) { product_group.outlet_stock_quantity(cart.outlet) }
      context 'when stock is present' do
        before do
          product_group.new_quantity = stock_multiplier
          product_group.stock_outlet_id = cart.outlet.id
          product_group.save!
        end
        it 'adds product group to the cart' do
          expect{
            cart.add_item(product_group.id, product_group_stock)
            }.to change(CartItem, :count).by(1)
        end
        it 'adds product quantity to the cart' do
          cart.add_item(product_group.id, product_group_stock)
          expect(cart.items.find_by(product: product_group).quantity).to eq(product_group_stock)
        end
        it 'adds only available product stock if outlet stock is less than requested quantity' do
          previous_quantity = cart.items.find_by(product: product_group).try(:quantity) || 0
          cart.add_item(product_group.id, stock_multiplier*100)
          expect(cart.items.find_by(product: product_group).quantity).to eq(previous_quantity + stock_multiplier)
        end
        describe "Update cart" do
          it 'updates product quantity in the cart' do
            cart.update_item(product_group.id, stock_multiplier)
            expect(cart.items.find_by(product: product_group).quantity).to eq(stock_multiplier)
          end
        end
      #   describe "Destroy item from cart" do
      #     before do
      #       cart.update_item(product.id, quantity)
      #     end
      #     it 'restores the product quantity to the stock' do
      #       stock_before_deletion = cart.outlet.product_stock(product).quantity
      #       cart.destroy_item(product.id)
      #       expect(cart.outlet.product_stock(product).quantity).to eq(stock_before_deletion + quantity)
      #     end
      #     it 'deletes the item from cart' do
      #       cart.destroy_item(product.id)
      #       expect(cart.items.find_by(product: product)).to be_nil
      #     end
      #   end
      end
    end
  end
end