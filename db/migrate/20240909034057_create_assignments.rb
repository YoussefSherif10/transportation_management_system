# frozen_string_literal: true

class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.references :driver, null: false, foreign_key: true
      t.references :truck, null: false, foreign_key: true
      t.datetime :assigned_at

      t.timestamps
    end
  end
end
