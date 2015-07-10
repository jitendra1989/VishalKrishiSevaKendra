require 'rails_helper'

RSpec.describe "admin/products/new", type: :view do
  let(:product) { Product.new }

  it "renders new product form" do
  	assign(:product, product)
  	render
  	assert_select "form[action=?][method=?]", admin_products_path, "post" do
  		assert_select "input#product_name[name=?]", "product[name]"
  		assert_select "input#product_code[name=?]", "product[code]"
  		assert_select "textarea#product_description[name=?]", "product[description]"
  		assert_select "input#product_price[name=?]", "product[price]"
  	end
  end
end
