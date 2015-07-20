require 'rails_helper'

RSpec.describe "admin/permissions/index", type: :view do
  let(:permissions) { Permission.all }

  		it "renders attributes in <p>" do
  			assign(:permissions, permissions)
  			render
  			expect(rendered).to match(/Name/)
  		end
end
