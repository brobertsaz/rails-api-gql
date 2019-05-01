FactoryBot.define do
  factory :post do
    title   { Faker::Quote.famous_last_words }
    kind    { 'post' }
    body    { Faker::Hipster.paragraph(3) }
    state   { 'published' }
    publish_at { Date.today }

    trait :article do
      kind { 'article' }
      source  { 'cnn' }
      url { Faker::Internet.url }
    end

    trait :video do
      kind { 'video' }
      url { "https://www.youtube.com/watch?v=r7OkwA4gLrM" }
    end

    after(:build) do |post|
      post.image.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'test.jpg')), filename: 'test.jpg', content_type: 'image/jpg')
    end
  end
end