FactoryBot.define do
  factory :member do
    state
    chamber
    name { Faker::Name.name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { Faker::Number.between(0, 1) }
    bioguide_id { Faker::Number.number(3) }
    title { Faker::Name.prefix }
  end
end
