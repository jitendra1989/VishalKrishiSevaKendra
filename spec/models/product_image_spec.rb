require 'rails_helper'

RSpec.describe ProductImage, type: :model do
	let(:product_image) { FactoryGirl.build(:product_image) }
	it { expect(product_image).to be_valid }
	it { expect(product_image).to respond_to(:product) }
end
