require 'spec_helper'

Rspec.describe Types::BillType, type: :request do
  let(:user) { create :user }
  let!(:bills) { create_list :bill, 4 }
  let!(:bill) { create :bill, summary: "drugs", feature_state: 'featured' }

  it 'gets list of all_bills' do
    query =
      <<~GQL
          query {
            allBills {
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
    data = json.dig('data', 'allBills', 'edges')
    expect(data.count).to eq 5
  end

  it 'gets featured_bills' do
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


  it 'gets a bill' do
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


  it 'gets filtered bills' do
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

  it 'gets unfiltered bills' do
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

  it 'searches bills' do
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

  it 'searches bills partial text' do
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

  it 'paginates bills' do
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
