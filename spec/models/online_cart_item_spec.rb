require 'rails_helper'

RSpec.describe OnlineCartItem, type: :model do
  let(:online_cart_item) { FactoryGirl.create(:online_cart_item) }
  it { expect(online_cart_item).to be_valid }
  it { expect(online_cart_item).to respond_to(:product) }
  it { expect(online_cart_item).to respond_to(:cart) }
  it "has a valid quantity" do
    online_cart_item.quantity = Faker::Lorem.word
    expect(online_cart_item).not_to be_valid
    online_cart_item.quantity = nil
    expect(online_cart_item).not_to be_valid
  end
end