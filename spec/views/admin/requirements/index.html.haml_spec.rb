require 'rails_helper'

RSpec.describe "admin/requirements/index", type: :view do

	let(:requirements) { Requirement.all }

	it "renders attributes in <p>" do
		assign(:requirements, requirements)
		render
		expect(rendered).to include('Facilitator')
	end
end
