# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'foobarbaz' }
    password_confirmation { password }
    confirmed_at { DateTime.yesterday }
    permissions do
      Array(with_permissions).map do |permission|
        association :permission, user: instance, allowed: permission.to_s
      end
    end

    transient do
      with_permissions { :member }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :without_password do
      password { nil }
    end

    trait :banned do
      banned_on { DateTime.now }
    end
  end
end
