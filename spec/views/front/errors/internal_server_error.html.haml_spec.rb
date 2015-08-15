require 'rails_helper'

RSpec.describe "front/errors/internal_server_error", type: :view do
	it 'shows the internal error page' do
		render
		expect(rendered).to include 'Please bear with us. Our Team has been notified about the problem.'
	end
end
