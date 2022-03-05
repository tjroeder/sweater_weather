FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password }
    api_key { Faker::Internet.password(min_length: 24, max_length: 58, mix_case: true) }
  end
end
