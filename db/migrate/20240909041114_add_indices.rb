# frozen_string_literal: true

class AddIndices < ActiveRecord::Migration[7.1]
  def change
    add_index :drivers, :email, unique: true
    add_index :trucks, :name
    add_index :assignments, %i[driver_id truck_id]
    add_index :assignments, :assigned_at
  end
end
