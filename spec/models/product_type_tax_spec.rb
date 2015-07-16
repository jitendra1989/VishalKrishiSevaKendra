require 'rails_helper'

RSpec.describe ProductTypeTax, type: :model do
	let(:product_type_tax) { FactoryGirl.build(:product_type_tax) }
	it { expect(product_type_tax).to be_valid }
	it { expect(product_type_tax).to respond_to(:product_type) }
	it { expect(product_type_tax).to respond_to(:tax) }
end
