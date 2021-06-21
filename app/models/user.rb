# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :confirmable, :recoverable, :rememberable, :validatable

  has_many :permissions, dependent: :destroy, autosave: true
  has_many :things, dependent: :destroy

  validates :username, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false

  def check_permissions?(permission)
    return false unless permissions

    # Does this user have any of the available permissions?
    allowed = permissions.map { |p| p.allowed.to_sym }
    return (allowed & permissions.map(&:to_sym)).any? if permission.is_a?(Array)

    allowed.include? permission
  end

  def needs_confirmation?
    return false if new_record?

    pending_any_confirmation { true }
  end

  def ban!
    self.banned_on = DateTime.now
    save!
  end

  def unban!
    self.banned_on = nil
    save!
  end

  # Banned users cannot log in.
  def active_for_authentication?
    super && !banned_on
  end
end
