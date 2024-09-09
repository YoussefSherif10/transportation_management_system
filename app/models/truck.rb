# frozen_string_literal: true

class Truck < ApplicationRecord
  has_many :assignments
  has_many :drivers, through: :assignments
  validates :name, presence: true
  validates :truck_type, presence: true

  scope :sorted, -> { order(created_at: :desc) }
end
