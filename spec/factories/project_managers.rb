FactoryGirl.define do
  factory :project_manager do
    company { create(:company) }
    name Faker::Name.name
    authentication_token { Faker::Lorem.characters(10) }
    sequence(:email)  { |n| "manager_#{n}@example.com" }
    password "123456"
    password_confirmation "123456"
  end
end
