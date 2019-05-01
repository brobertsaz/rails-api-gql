FactoryBot.define do
  factory :alert do
    alert_category_id { 1 }
    message { 'I am an alert' }
  end
end
