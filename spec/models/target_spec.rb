# frozen_string_literal: true

# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :string
#  longitude  :string
#  radius     :float
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint
#
# Indexes
#
#  index_targets_on_title     (title) UNIQUE
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#
require 'rails_helper'

RSpec.describe Target, type: :model do
  subject { build(:target) }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'attributes' do
    it { is_expected.to have_db_column(:title) }
    it { is_expected.to have_db_column(:radius) }
    it { is_expected.to have_db_column(:longitude) }
    it { is_expected.to have_db_column(:latitude) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end
end
