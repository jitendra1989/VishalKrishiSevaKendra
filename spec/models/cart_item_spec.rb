require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart_item) { FactoryGirl.build(:cart_item) }
  it { expect(cart_item).to be_valid }
  it { expect(cart_item).to respond_to(:product) }
  it { expect(cart_item).to respond_to(:cart) }
  it "has a valid quantity" do
    cart_item.quantity = Faker::Lorem.word
    expect(cart_item).to_not be_valid
    cart_item.quantity = nil
    expect(cart_item).to_not be_valid
  end
end
