require 'rails_helper'

RSpec.describe Front::ProductsHelper, type: :helper do
	let(:product) { FactoryGirl.create(:product) }
	describe "decorated frontend_price" do
		it "returns the regular price if no sale price is provided" do
			product.sale_price = 0
			expect(helper.decorated_frontend_price(product)).to include(number_to_currency product.price_with_taxes)
		end
		it "returns the regular price with a strikeout class" do
			expect(helper.decorated_frontend_price(product)).to include(number_to_currency product.price_with_taxes)
		end
		it "returns the sale price with taxes" do
			expect(helper.decorated_frontend_price(product)).to include(number_to_currency product.sale_price_with_taxes)
		end
	end
end
