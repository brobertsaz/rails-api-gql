FactoryBot.define do
  factory :committee do
    name        { Faker::Quote.famous_last_words }
    bioguide_id { Faker::Number.number(5) }
  end
end
