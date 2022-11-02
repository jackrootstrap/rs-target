# frozen_string_literal: true

require 'rails_helper'

describe 'Services::TargetService::CompatibleTargetFinder', type: :service do
  subject { TargetService::CompatibleTargetFinder.new(target) }

  let(:topic) { create(:topic) }
  let!(:south_targets) { create_list(:target, 3, :with_south_location, topic: topic, radius: 1.0) }
  let!(:north_targets) { create_list(:target, 3, :with_north_location, topic: topic, radius: 1.0) }

  context 'when target matches the criteria - north targets' do
    let!(:target) { create(:target, :with_north_location, topic: topic, radius: 2000.0) }

    it 'sends notifications to the matched users' do
      expect { subject.call }.to change(Notification, :count).by(3)
    end

    it 'sends emails to the matched users' do
      expect { subject.call }.to have_enqueued_job(Noticed::DeliveryMethods::Email).exactly(3)
    end
  end

  context 'when target matches the criteria - all targets' do
    let!(:target) { create(:target, :with_center_location, topic: topic, radius: 10_000.0) }

    it 'sends notifications to the matched users' do
      expect { subject.call }.to change(Notification, :count).by(6)
    end

    it 'sends emails to the matched users' do
      expect { subject.call }.to have_enqueued_job(Noticed::DeliveryMethods::Email).exactly(6)
    end
  end

  context 'when target does not match the criteria' do
    let!(:target) { create(:target, :with_center_location, topic: topic, radius: 0.0) }

    it 'sends notifications to the matched users' do
      expect { subject.call }.to change(Notification, :count).by(0)
    end

    it 'sends emails to the matched users' do
      expect { subject.call }.to have_enqueued_job(Noticed::DeliveryMethods::Email).exactly(0)
    end
  end
end
