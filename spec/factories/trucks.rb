FactoryBot.define do
  factory :truck do
    name { Faker::Vehicle.make_and_model }
    truck_type { ['Flatbed', 'Refrigerated', 'Box'].sample }
  end
end