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
FactoryBot.define do
  factory :target do
    user
    title { Faker::Lorem.unique.word }
    radius { rand(0.1...1000.0).round(1) }
    latitude { Faker::Address.latitude.round(10) }
    longitude { Faker::Address.longitude.round(10) }
    topic
  end
end
