FactoryBot.define do
  factory :tag do
    name { Faker::WorldOfWarcraft.hero }
  end
end
