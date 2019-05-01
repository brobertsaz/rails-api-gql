require 'spec_helper'

describe Mutations::FavoritePost do
  let!(:user) { create :user }
  let!(:post) { create :post }

  def perform(args = {})
    described_class.new(object: nil, context: { current_user: user }).resolve(args)
  end

  it 'favorites a post' do
    result = perform(
        post_id: post.id
    )

    post = result[:post]
    expect(post.favorites.count).to eq 1
    expect(user.favorites.count).to eq 1
  end

  it 'unfavorites a post' do
    user.favorites.create(favoritable: post)
    
    result = perform(
        post_id: post.id
    )

    post = result[:post]
    expect(post.favorites.count).to eq 0
    expect(user.favorites.count).to eq 0
  end
end
