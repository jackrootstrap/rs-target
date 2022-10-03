# frozen_string_literal: true

class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :name, null: false

      t.timestamps
      t.index :name, unique: true
    end
  end
end
