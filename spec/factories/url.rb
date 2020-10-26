FactoryBot.define do
  factory :url do
    original_url { Faker::Internet.url }
    slug { Faker::Alphanumeric.alphanumeric(number: 7) }
    hits { Faker::Number.digit }
  end
end
