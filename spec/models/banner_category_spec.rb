require 'rails_helper'

RSpec.describe BannerCategory, type: :model do
	let(:banner_category) { FactoryGirl.create(:banner_category) }
	it { expect(banner_category).to be_valid }
	it { expect(banner_category).to respond_to(:banner) }
	it { expect(banner_category).to respond_to(:category) }
end
