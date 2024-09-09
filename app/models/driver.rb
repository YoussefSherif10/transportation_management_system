# frozen_string_literal: true

class Driver < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :assignments
  has_many :trucks, through: :assignments
end
