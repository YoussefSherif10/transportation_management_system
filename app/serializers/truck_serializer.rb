# frozen_string_literal: true

class TruckSerializer
  include JSONAPI::Serializer

  attributes :name, :truck_type

  attribute :created_at do |truck|
    truck.created_at.iso8601
  end

  has_many :drivers
end
