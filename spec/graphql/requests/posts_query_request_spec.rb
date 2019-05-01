require 'spec_helper'

Rspec.describe Types::PostType, type: :request do
  let!(:posts) { create_list :post, 5 }
  # let!(:video_posts) { create_list :post, 5, :video }
  # let!(:article_posts) { create_list :post, 5, :article }

  it 'gets list of all_post' do
    query =
      <<~GQL
          query {
            posts {
              edges {
                node {
                  id
                  title
                }
              }
            }
          }
      GQL

    post '/graphql', params: { query: query }
    binding.pry
    data = json.dig('data', 'allPost', 'edges')
    expect(data.count).to eq 15
  end

  xit 'gets featured_bills' do
    query =
      <<~GQL
          query {
            featuredBills {
              edges {
                node {
                  id
                  title
                }
              }
            }
          }
      GQL

    post '/graphql', params: { query: query }
    data = json.dig('data', 'featuredBills', 'edges')
    expect(data.count).to eq Bill.special.count
  end


  xit 'gets a bill' do
    query =
      <<~GQL
          query {
            bill (id: #{Bill.first.id}) {
              id
              number
            }
          }
      GQL

    post '/graphql', params: { query: query }
    data = json.dig('data', 'bill')
    expect(data['id']).to eq Bill.first.id.to_s
    expect(data['number']).to eq Bill.first.number
  end


  xit 'gets filtered bills' do
    user.favorites.create(favoritable: bills.last)
    query =
        <<~GQL
          query {
            bills (userId: #{user.id}, filter: "following") {
              edges {
                node {
                  id
                  number
                  title
                }
              }
            }
          }
    GQL

    post '/graphql', params: { query: query }
    data = json.dig('data', 'bills', 'edges')
    expect(data.count).to eq 1
    expect(data.first['node']['number']).to eq bills.last.number
  end

  xit 'gets unfiltered bills' do
    query =
        <<~GQL
          query {
            bills (userId: #{user.id}, filter: "test") {
              edges {
                node {
                  id
                  title
                }
              }
            }
          }
    GQL

    post '/graphql', params: { query: query }
    data = json.dig('data', 'bills', 'edges')
    expect(data.count).to eq 5
  end

  xit 'searches bills' do
    query =
        <<~GQL
          query {
            searchBills (term: "drugs") {
              edges {
                node {
                  id
                  number
                  title
                }
              }
            }
          }
    GQL

    post '/graphql', params: { query: query }
    data = json.dig('data', 'searchBills', 'edges')
    expect(data.count).to eq 1
    expect(data.first['node']['number']).to eq bill.number
  end

  xit 'searches bills partial text' do
    query =
        <<~GQL
          query {
            searchBills (term: "drug") {
              edges {
                node {
                  id
                  title
                  number
                }
              }
            }
          }
    GQL

    post '/graphql', params: { query: query }
    data = json.dig('data', 'searchBills', 'edges')
    expect(data.count).to eq 1
    expect(data.first['node']['number']).to eq bill.number
  end

  xit 'paginates bills' do
    query =
        <<~GQL
          query {
            allBills (first: 3) {
              pageInfo {
                endCursor
                startCursor
                hasPreviousPage
                hasNextPage
              }
              edges {
                node {
                  id
                  title
                  number
                }
              }
            }
          }
    GQL

    post '/graphql', params: { query: query }
    data = json.dig('data', 'allBills', 'edges')
    expect(data.count).to eq 3
    expect(json.dig('data', 'allBills', 'pageInfo', 'hasNextPage')).to be true
  end
end
