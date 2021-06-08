# frozen_string_literal: true

# The Thing Model. It tracks the Things.
class Thing < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :due_this_week, -> { where(arrived_on: nil, due_on: Date.today.beginning_of_week..Date.today.end_of_week) }
  scope :due_this_month, -> { where(arrived_on: nil, due_on: Date.today.beginning_of_month..Date.today.end_of_month) }

  scope :arrived_this_week, -> { where(arrived_on: Date.today.beginning_of_week..Date.today.end_of_week) }
  scope :arrived_this_month, -> { where(arrived_on: Date.today.beginning_of_month..Date.today.end_of_month) }

  def due_this_week?(day = due_on)
    return false unless arrived_on.nil?
    return false if due_on.nil?

    (Date.today.beginning_of_week..Date.today.end_of_week).include?(day)
  end

  def due_this_month?(day = due_on)
    return false unless arrived_on.nil?
    return false if due_on.nil?

    (Date.today.beginning_of_month..Date.today.end_of_month).include?(day)
  end

  def arrived_this_week?(day = arrived_on)
    return false if arrived_on.nil?

    (Date.today.beginning_of_week..Date.today.end_of_week).include?(day)
  end

  def arrived_this_month?(day = arrived_on)
    return false if arrived_on.nil?

    (Date.today.beginning_of_month..Date.today.end_of_month).include?(day)
  end
end
