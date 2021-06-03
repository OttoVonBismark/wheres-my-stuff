# frozen_string_literal: true

FactoryBot.define do
  factory :thing do
    name { Faker::Food.fruits }

    user
  end
end
