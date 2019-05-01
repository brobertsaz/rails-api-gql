FactoryBot.define do
  factory :state do
    abbreviation { Faker::Address.state_abbr }
    name { Faker::Address.state }
  end
end
