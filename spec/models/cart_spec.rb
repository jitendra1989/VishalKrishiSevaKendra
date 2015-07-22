require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { FactoryGirl.build(:cart) }
  it { expect(cart).to be_valid }
  it { expect(cart).to respond_to(:customer) }
  it { expect(cart).to respond_to(:user) }
  it { expect(cart).to respond_to(:outlet) }

  describe "per customer per outlet" do
  	let(:duplicate_cart) { FactoryGirl.build(:cart, customer: cart.customer, outlet: cart.outlet) }
  	let(:new_outlet_cart) { FactoryGirl.build(:cart, customer: cart.customer) }
  	before do
  		cart.save!
  	end
  	it { expect(duplicate_cart).to_not be_valid }
  	it { expect(new_outlet_cart).to be_valid }
  end
end
