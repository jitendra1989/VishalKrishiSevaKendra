require 'rails_helper'

RSpec.describe "front/errors/not_found", type: :view do
	it 'shows the error not found page' do
		render
		expect(rendered).to include 'Page Not found.'
	end
end
