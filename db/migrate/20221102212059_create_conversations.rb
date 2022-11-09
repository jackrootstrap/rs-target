# frozen_string_literal: true

class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :sender, null: false
      t.references :receiver, null: false
      t.references :topic, null: false

      t.timestamps
    end

    add_index :conversations, %i[sender_id receiver_id topic_id], unique: true, name: 'user_conversations'
  end
end
