# frozen_string_literal: true

class CreateDrivers < ActiveRecord::Migration[7.1]
  def change
    create_table :drivers do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
