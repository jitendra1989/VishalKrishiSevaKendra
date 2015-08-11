require 'rails_helper'

RSpec.describe "front/pages/show", type: :view do
	let(:page) { FactoryGirl.create(:content_page) }

	it "renders requested page" do
		assign(:page, page)
		render
		expect(rendered).to include(page.title)
	end
end
