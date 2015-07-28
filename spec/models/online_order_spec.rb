require 'rails_helper'

RSpec.describe OnlineOrder, type: :model do
  let(:online_order) { FactoryGirl.build(:online_order) }
  it { expect(online_order).to be_valid }
  it { expect(online_order).to respond_to(:customer) }
end
