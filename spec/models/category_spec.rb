require 'rails_helper'

RSpec.describe Category, type: :model do
	let(:category) { FactoryGirl.create(:category) }
	let(:sub_category) { FactoryGirl.build(:sub_category, parent: category) }
	it { expect(category).to be_valid }
	it { expect(sub_category).to be_valid }
	it { expect(category).to respond_to(:product_categories) }
	it { expect(category).to respond_to(:products) }
	it { expect(category).to respond_to(:banners) }
	it { expect(category).to respond_to(:banner_categories) }
	it "has a valid name" do
		category.name = nil
		expect(category).to_not be_valid
	end
	describe "on deleting a category" do
		before { sub_category.save! }
		it "deletes all sub categories" do
			expect {
				category.destroy
			}.to change(Category, :count).by(-2)
		end
	end
end
