# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id           :bigint           not null, primary key
#  params       :jsonb
#  read_at      :datetime
#  type         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :bigint           not null
#
# Indexes
#
#  index_notifications_on_read_at       (read_at)
#  index_notifications_on_recipient_id  (recipient_id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { create(:notification) }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'attributes' do
    it { is_expected.to have_db_column(:read_at) }
    it { is_expected.to have_db_column(:type).with_options(null: false) }
    it { is_expected.to have_db_column(:recipient_id).with_options(null: false) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:recipient) }
  end
end
