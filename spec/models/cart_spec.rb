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
    let(:quantity) { Faker::Number.digit.to_i }
    it 'adds product to the cart' do
      expect{
        cart.add(product.id, quantity)
        }.to change(CartItem, :count).by(1)
    end
    it 'adds product quantity to the cart' do
      cart.add(product.id, quantity)
      expect(cart.items.find_by(product: product).quantity).to be >= quantity
    end
  end
end