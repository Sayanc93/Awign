FactoryGirl.define do
  factory :intern do
    company { create(:company) }
    name Faker::Name.name
    authentication_token { Faker::Lorem.characters(10) }
    sequence(:email)  { |n| "intern_#{n}@example.com" }
    password "123456"
    password_confirmation "123456"
    college Faker::Name.name
    assigned false
    workforce
  end
end
