require 'rails_helper'
require 'factory_bot'

describe Alert do
  let(:alert_category) { create(:alert_category) }
  let(:alert) { create(:alert, alert_category_id: alert_category.id) }

# These two tests need mock-redis to be set up
  # describe 'queue_blast' do
  #   it 'sends the alert id to AlertWorker' do
  #   end
  # end
  #
  # describe 'send_blast' do
  #   it 'pushes the notification to each user' do
  #   end
  # end

  describe 'category' do
    it 'returns DAILY_SCOPE when alert_category.name == Notable Daily Scopes' do
      expect(alert.category).to eql('DAILY_SCOPE')
    end

# This test needs mock-redis to be set up
    # it 'returns RANDOM when alert_category.name === anything else' do
    #   expect(alert.category).to eql('RANDOM')
    # end
  end
end
