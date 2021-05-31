# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'foobarbaz' }
    password_confirmation { password }
    confirmed_at { DateTime.yesterday }

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :without_password do
      password { nil }
    end
  end
end
