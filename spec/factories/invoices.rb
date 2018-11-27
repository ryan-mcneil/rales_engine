FactoryBot.define do
  factory :invoice do
    merchant
    customer
    sequence(:status) { |n| "Status#{n}" }
  end
end
