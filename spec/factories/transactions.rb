FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| "123412341234123#{n}" }
    sequence(:credit_card_expiration_date) { |n| "12/2#{n}" }
    sequence(:result) { |n| "Result#{n}" }

  end
end
