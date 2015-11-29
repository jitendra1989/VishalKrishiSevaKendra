require 'rails_helper'

RSpec.describe Requirement, type: :model do
  let(:requirement) { FactoryGirl.build(:requirement) }

  it { expect(requirement).to be_valid }
  it { expect(requirement).to respond_to(:customer) }
  it { expect(requirement).to respond_to(:user) }
  it { expect(requirement).to respond_to(:outlet) }
  it { expect(requirement).to respond_to(:products) }

end
