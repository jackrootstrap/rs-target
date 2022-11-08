# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :bigint           not null
#  sender_id   :bigint           not null
#  topic_id    :bigint           not null
#
# Indexes
#
#  index_conversations_on_receiver_id  (receiver_id)
#  index_conversations_on_sender_id    (sender_id)
#  index_conversations_on_topic_id     (topic_id)
#  user_conversations                  (sender_id,receiver_id,topic_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  subject { create(:conversation) }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'attributes' do
    it { is_expected.to have_db_column(:topic_id).with_options(null: false) }
    it { is_expected.to have_db_column(:sender_id).with_options(null: false) }
    it { is_expected.to have_db_column(:receiver_id).with_options(null: false) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:sender) }
    it { is_expected.to belong_to(:receiver) }
    it { is_expected.to belong_to(:topic) }
  end

  describe 'index' do
    it { is_expected.to have_db_index(:receiver_id) }
    it { is_expected.to have_db_index(:sender_id) }
    it { is_expected.to have_db_index(:topic_id) }
    it { is_expected.to have_db_index(%i[sender_id receiver_id topic_id]) }
  end
end
