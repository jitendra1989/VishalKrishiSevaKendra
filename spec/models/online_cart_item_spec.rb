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
end