FactoryBot.define do
  factory :book do
    title { "MyString" }
    author { "MyString" }
    coverImagePath { "MyString" }
    genre { "MyString" }
    user { nil }
  end
end
