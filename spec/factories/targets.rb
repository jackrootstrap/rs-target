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
FactoryBot.define do
  factory :target do
    user
    title { Faker::Lorem.unique.word }
    radius { Faker::Number.decimal }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    topic
  end
end
