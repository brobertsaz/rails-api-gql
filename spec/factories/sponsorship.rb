FactoryBot.define do
  factory :sponsorship do
    bill
    member
    kind { 'primary' }
  end
end
