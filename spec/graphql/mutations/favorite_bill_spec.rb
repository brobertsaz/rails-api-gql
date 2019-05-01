require 'spec_helper'

describe Mutations::FavoriteBill do
  let!(:user) { create :user }
  let!(:bill) { create :bill }

  def perform(args = {})
    described_class.new(object: nil, context: { current_user: user }).resolve(args)
  end

  it 'favorites a bill' do
    result = perform(
        bill_id: bill.id
    )

    bill = result[:bill]
    expect(bill.favorites.count).to eq 1
    expect(user.favorites.count).to eq 1
  end

  it 'unfavorites a bill' do
    user.favorites.create(favoritable: bill)
    
    result = perform(
        bill_id: bill.id
    )

    bill = result[:bill]
    expect(bill.favorites.count).to eq 0
    expect(user.favorites.count).to eq 0
  end
end
