FactoryBot.define do
  factory :bill do
    congress
    number { Faker::Number.number(15) }
    title { Faker::Quote.famous_last_words }
    summary { Faker::Hipster.paragraph(2) }
    full_text_url { Faker::Internet.url }
    introduced_on { Faker::Date.backward(21) }
    house_voted_on { Faker::Date.backward(14) }
    senate_voted_on { Faker::Date.backward(7) }
    enacted_on { Faker::Date.backward(1) }
    feature_state { ['', 'featured', 'highlighted'].sample }
  end
end
