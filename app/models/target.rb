# frozen_string_literal: true

# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :decimal(15, 10)  not null
#  longitude  :decimal(15, 10)  not null
#  radius     :decimal(6, 1)    not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_targets_on_title_and_user_id  (title,user_id) UNIQUE
#  index_targets_on_topic_id           (topic_id)
#  index_targets_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
class Target < ApplicationRecord
  MAX_USER_TARGETS = 10

  acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude

  belongs_to :user, counter_cache: true
  belongs_to :topic

  has_noticed_notifications model_name: 'Notification'

  validates :title, presence: true, uniqueness: { scope: :user }
  validates :radius, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates_with TargetValidator, on: :create
end
