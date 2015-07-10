require 'rails_helper'

RSpec.describe "admin/products/edit", type: :view do

	let(:product) { FactoryGirl.create(:product) }

	it "renders the edit products form" do
	  assign(:product, product)
	  render
	  assert_select "form[action=?][method=?]", admin_product_path(product), "post" do
	    assert_select "input#product_name[name=?]", "product[name]"
	    assert_select "input#product_code[name=?]", "product[code]"
	    assert_select "textarea#product_description[name=?]", "product[description]"
	    assert_select "input#product_price[name=?]", "product[price]"
	  end
	end
end
