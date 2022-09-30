# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :topic do
    name { Faker::Lorem.word }

    trait :with_image do
      transient do
        sequence(:tmp_img) { |n| Tempfile.new(["tmp_img_#{n}", 'jpg']).path }
      end

      image { Rack::Test::UploadedFile.new(tmp_img, 'image/png') }
    end
  end
end
