require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.build(:order) }
  it { expect(order).to be_valid }
  it { expect(order).to respond_to(:customer) }
  it { expect(order).to respond_to(:user) }

  it "has a valid discount amount" do
    order.discount_amount = Faker::Lorem.word
    expect(order).to_not be_valid
    order.discount_amount = nil
    expect(order).to_not be_valid
  end
  it "has a valid customer" do
    order.customer = nil
    expect(order).to_not be_valid
  end
  it "has a valid user" do
    order.user = nil
    expect(order).to_not be_valid
  end
  it "has a valid outlet" do
    order.outlet = nil
    expect(order).to_not be_valid
  end
end
