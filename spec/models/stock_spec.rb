require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:stock) { FactoryGirl.build(:stock) }
  it { expect(stock).to be_valid }
  it { expect(stock).to respond_to(:product) }
  it { expect(stock).to respond_to(:outlet) }
  it { expect(stock).to respond_to(:opening) }
  it { expect(stock).to respond_to(:new_quantity) }
  it { expect(stock).to respond_to(:ordered) }
  it { expect(stock).to respond_to(:invoiced) }
  it "has a valid product" do
    stock.product = nil
    expect(stock).to_not be_valid
  end
  it "has a valid outlet" do
    stock.outlet = nil
    expect(stock).to_not be_valid
  end
  it "has a valid quantity" do
    stock.quantity = Faker::Lorem.word
    expect(stock).to_not be_valid
    stock.quantity = nil
    expect(stock).to_not be_valid
  end
  it "has a valid opening" do
    stock.opening = Faker::Lorem.word
    expect(stock).to_not be_valid
    stock.opening = nil
    expect(stock).to_not be_valid
  end
  it "has a valid ordered" do
    stock.ordered = Faker::Lorem.word
    expect(stock).to_not be_valid
    stock.ordered = nil
    expect(stock).to_not be_valid
  end
  it "has a valid invoiced" do
    stock.invoiced = Faker::Lorem.word
    expect(stock).to_not be_valid
    stock.invoiced = nil
    expect(stock).to_not be_valid
  end
  it "has a valid new_quantity" do
    stock.new_quantity = Faker::Lorem.word
    expect(stock).to_not be_valid
    stock.new_quantity = nil
    expect(stock).to_not be_valid
  end
  it "has a valid code" do
    stock.code = nil
    expect(stock).to_not be_valid
  end
end
