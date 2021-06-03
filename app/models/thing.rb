# frozen_string_literal: true

# The Thing Model. It tracks the Things.
class Thing < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
