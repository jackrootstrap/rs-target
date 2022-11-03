# frozen_string_literal: true

require 'rails_helper'

describe 'Services::ConversationService::Creator', type: :service do
  subject { ConversationService::Creator.new(sender: sender, receivers: receivers, topic: topic) }

  let(:topic) { create(:topic) }
  let!(:sender) { create(:user) }
  let!(:receivers) { create_list(:user, 3) }

  it 'creates conversations between sender and receivers' do
    expect { subject.call }.to change(Conversation, :count).by(3)
  end
end
