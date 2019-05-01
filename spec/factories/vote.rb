FactoryBot.define do
  factory :vote do
    chamber
    bill
    member
    position { %w[yes no not_voting speaker present].sample }
  end
end
