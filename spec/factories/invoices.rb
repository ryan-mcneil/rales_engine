FactoryBot.define do
  factory :invoice do
    merchant { nil }
    customer { nil }
    status { "MyString" }
    string { "MyString" }
  end
end
