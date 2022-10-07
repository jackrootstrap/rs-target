# frozen_string_literal: true

class CreateTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.decimal :radius, precision: 6, scale: 1, null: false
      t.decimal :latitude, precision: 15, scale: 10, null: false
      t.decimal :longitude, precision: 15, scale: 10, null: false
      t.references :topic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
      t.index %i[title user_id], unique: true
    end
  end
end
