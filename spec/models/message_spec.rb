# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  body            :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { create(:message) }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'attributes' do
    it { is_expected.to have_db_column(:body).with_options(null: false) }
    it { is_expected.to have_db_column(:user_id).with_options(null: false) }
    it { is_expected.to have_db_column(:conversation_id).with_options(null: false) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:conversation) }
  end

  describe 'index' do
    it { is_expected.to have_db_index(:conversation_id) }
    it { is_expected.to have_db_index(:user_id) }
  end
end
