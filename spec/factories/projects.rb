FactoryGirl.define do
  factory :project do
    company { create(:company) }
    name Faker::Name.name
    category { Faker::Lorem.characters(10) }
    project_manager nil
  end
end
