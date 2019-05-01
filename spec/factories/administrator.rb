FactoryBot.define do
  factory :administrator do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
