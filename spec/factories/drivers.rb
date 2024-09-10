FactoryBot.define do
  factory :driver do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
  end
end