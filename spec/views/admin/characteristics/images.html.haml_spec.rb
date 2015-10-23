require 'rails_helper'

RSpec.describe "admin/characteristics/images", type: :view do

	let(:characteristic) { FactoryGirl.create(:characteristic) }

	before do
		characteristic.images << FactoryGirl.create(:characteristic_image)
	end

	it "renders all characteristic images" do
		assign(:characteristic, characteristic)
		render
    expect(rendered).to have_css('img')
	end
end
