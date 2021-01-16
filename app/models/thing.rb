# frozen_string_literal: true

# The Thing Model. It tracks the Things.
class Thing < ApplicationRecord
  validates :name, presence: true
end
