# frozen_string_literal: true

class CreateTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.float :radius
      t.string :latitude
      t.string :longitude
      t.references :topic, null: false, foreign_key: true

      t.timestamps
      t.index :title, unique: true
    end
  end
end
