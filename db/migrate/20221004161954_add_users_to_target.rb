# frozen_string_literal: true

class AddUsersToTarget < ActiveRecord::Migration[7.0]
  def change
    add_reference :targets, :user, index: true
  end
end
