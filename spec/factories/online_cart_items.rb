FactoryGirl.define do
	factory :online_cart_item do
		product
		association :cart, factory: :online_cart
	end

end
