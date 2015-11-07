require 'rails_helper'

RSpec.describe Quotation, type: :model do
  let(:quotation) { FactoryGirl.build(:quotation) }
  it { expect(quotation).to be_valid }
  it { expect(quotation).to respond_to(:customer) }
  it { expect(quotation).to respond_to(:user) }
  it { expect(quotation).to respond_to(:products) }

  it 'has discount equal to or less than user allowed discount' do
    #validate to add name and price
    quotation.valid?
    total = quotation.products.first.price * quotation.products.first.quantity
    discount_allowed = quotation.user.allowed_discount
    quotation.discount_amount = (total * discount_allowed/100) + 101
    expect(quotation).not_to be_valid
  end

  it 'has at least one product' do
    quotation.products = []
    expect(quotation).not_to be_valid
  end
  it "has a valid discount amount" do
    quotation.discount_amount = Faker::Lorem.word
    expect(quotation).to_not be_valid
    quotation.discount_amount = nil
    expect(quotation).to_not be_valid
  end
  it "has a valid customer" do
    quotation.customer = nil
    expect(quotation).to_not be_valid
  end
  it "has a valid user" do
    quotation.user = nil
    expect(quotation).to_not be_valid
  end
end
