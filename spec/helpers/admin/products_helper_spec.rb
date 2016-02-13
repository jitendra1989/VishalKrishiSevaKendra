require 'rails_helper'

RSpec.describe Admin::ProductsHelper, type: :helper do
	let(:product) { FactoryGirl.create(:product) }
	describe "decorated price" do
		it "returns the regular price if no sale price is provided" do
			product.sale_price = 0
			expect(helper.decorated_price(product)).to include(number_to_currency product.price_with_taxes)
		end
		it "returns the regular price with a strikeout class" do
			expect(helper.decorated_price(product)).to include(number_to_currency product.price_with_taxes)
		end
		it "returns the sale price with taxes" do
			expect(helper.decorated_price(product)).to include(number_to_currency product.sale_price_with_taxes)
		end
	end
	describe "large decorated price" do
		it "returns the regular price if no sale price is provided" do
			product.sale_price = 0
			expect(helper.large_decorated_price(product)).to include(number_to_currency product.price_with_taxes)
		end
		it "returns the regular price with a strikeout class" do
			expect(helper.large_decorated_price(product)).to include(number_to_currency product.price_with_taxes)
		end
		it "returns the sale price with taxes" do
			expect(helper.large_decorated_price(product)).to include(number_to_currency product.sale_price_with_taxes)
		end
		it "returns the sale discount amount" do
			discount_amount = product.price_with_taxes - product.sale_price_with_taxes
			discount_percent = discount_amount*100/product.price_with_taxes
			expect(helper.large_decorated_price(product)).to include(discount_percent.round.to_s)
		end
	end
end
