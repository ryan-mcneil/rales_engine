FactoryBot.define do
  factory :item do
    merchant
    sequence(:name) { |n| "Name#{n}" }
    sequence(:description) { |n| "Description#{n}" }
    sequence(:unit_price) { |n| n*100 }
  end
end
