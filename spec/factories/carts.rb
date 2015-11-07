FactoryGirl.define do
  factory :cart do
    customer
    association :user, factory: :user_with_roles
    outlet
  end

end
