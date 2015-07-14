require 'rails_helper'

RSpec.describe Quotation, type: :model do
  let(:quotation) { FactoryGirl.build(:quotation) }
  it { expect(quotation).to be_valid }
  it { expect(quotation).to respond_to(:customer) }
  it { expect(quotation).to respond_to(:user) }

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
