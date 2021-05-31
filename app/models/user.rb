# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :confirmable, :recoverable, :rememberable, :validatable

  validates :username, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
end
