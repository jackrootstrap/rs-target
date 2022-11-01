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
FactoryBot.define do
  factory :notification do
    recipient { create(:user) }
    type { TargetNotification.name }
  end
end
