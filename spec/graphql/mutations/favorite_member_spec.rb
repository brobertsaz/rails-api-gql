require 'spec_helper'

describe Mutations::FavoriteMember do
  let!(:user) { create :user }
  let!(:member) { create :member }

  def perform(args = {})
    described_class.new(object: nil, context: { current_user: user }).resolve(args)
  end

  it 'favorites a member' do
    result = perform(
        member_id: member.id
    )

    member = result[:member]
    expect(member.favorites.count).to eq 1
    expect(user.favorites.count).to eq 1
  end

  it 'unfavorites a member' do
    user.favorites.create(favoritable: member)
    
    result = perform(
        member_id: member.id
    )

    member = result[:member]
    expect(member.favorites.count).to eq 0
    expect(user.favorites.count).to eq 0
  end
end
