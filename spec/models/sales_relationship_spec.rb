require 'rails_helper'

RSpec.describe SalesRelationship, type: :model do
	let(:sales_relationship) { FactoryGirl.build(:sales_relationship) }
	it { expect(sales_relationship).to be_valid }
	it { expect(sales_relationship).to respond_to(:product) }
	it { expect(sales_relationship).to respond_to(:related_product) }
	it "has a valid product" do
		sales_relationship.product = nil
		expect(sales_relationship).not_to be_valid
	end
	it "has a valid related_product" do
		sales_relationship.related_product = nil
		expect(sales_relationship).not_to be_valid
	end
end
