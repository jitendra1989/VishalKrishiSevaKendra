FactoryGirl.define do
	factory :receipt, aliases: [:cash_receipt] do
		code { Faker::Code.isbn }
		amount { BigDecimal.new(Faker::Commerce.price.to_s) }
		order
		user
		payment_method { Receipt::PAYMENT_METHODS.keys.first }
		factory :cheque_receipt do
			cheque_number { Faker::Number.number(7) }
			cheque_date { Faker::Date.forward(23) }
			cheque_bank { Faker::Company.name }
		end
		factory :card_receipt do
			card_number { Faker::Business.credit_card_number }
		end
	end

end
