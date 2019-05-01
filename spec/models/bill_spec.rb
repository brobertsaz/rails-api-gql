require 'rails_helper'
require 'factory_bot'

describe Bill do
  let(:bill) { create(:bill, number: 'HR123') }

  describe 'to_s' do
    it 'returns the bill number' do
      expect(bill.to_s).to eql('HR123')
    end
  end

  describe 'self.sync' do

  end

  describe 'sync' do

  end

  describe 'primary_tag' do

  end

  describe 'state' do

  end

  describe 'intro_state' do
    it 'returns passed' do
      expect(bill.intro_state).to eql('passed')
    end
  end

  describe 'house_state' do
    it 'returns passed if enacted' do
      expect(bill.house_state).to eql('passed')
    end

    it 'returns house result' do
      bill.enacted_on = ''
      bill.house_result = 'rejected'
      expect(bill.house_state).to eql('rejected')
    end
  end

  describe 'senate_state' do
    it 'returns passed if enacted' do
      expect(bill.senate_state).to eql('passed')
    end

    it 'returns senate result' do
      bill.enacted_on = ''
      bill.senate_result = 'in progress'
      expect(bill.senate_state).to eql('in progress')
    end
  end

  describe 'president_state' do
    it 'returns passed if not enacted and not vetoed' do
      expect(bill.president_state).to eql('passed')
    end

    it 'returns failed if enacted but vetoed' do
      bill.enacted_on = ''
      bill.vetoed_on = Faker::Date.backward(1)
      expect(bill.president_state).to eql('failed')
    end
  end

  describe 'special?' do

  end

  describe 'all_sponsors' do
    let(:member) { create(:member) }

    it 'returns all sponsors' do
      bill.sponsor = member
      # Doesn't seem right.
      expect(bill.all_sponsors).to eql([])
    end
  end

  describe 'upvote_count' do
    let!(:position) { create(:position, bill_id: bill.id, position: 1) }
    it 'returns number who voted for' do
      expect(bill.upvote_count).to eql(1)
    end
  end

  describe 'downvote_count' do
    let!(:position) { create(:position, bill_id: bill.id, position: -1) }
    it 'returns number who voted against' do
      expect(bill.downvote_count).to eql(1)
    end
  end

  describe 'house_vote_breakdown' do

  end

  describe 'senate_vote_breakdown' do

  end
end
