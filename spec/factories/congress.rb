FactoryBot.define do
  factory :congress do
    number { Faker::Number.number(3) }
  end
end
