FactoryBot.define do
  factory :invoice do
    merchant
    customer
    status { "pending" }
  end
end
