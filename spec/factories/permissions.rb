# frozen_string_literal: true

FactoryBot.define do
  factory :permission, class: Permission do
    user
    allowed { 'member' }
  end
end
