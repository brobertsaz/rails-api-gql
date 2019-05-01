FactoryBot.define do
  factory :position do
    bill_id { FactoryBot.create(:bill).id }
    user_id { FactoryBot.create(:user).id }
    position { Faker::Number.between(-1, 1) }
  end
end
