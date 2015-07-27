require 'rails_helper'

RSpec.describe OnlineCart, type: :model do
  let(:online_cart) { FactoryGirl.create(:online_cart) }
  it { expect(online_cart).to be_valid }
  it { expect(online_cart).to respond_to(:customer) }
end