require 'spec_helper'

Rspec.describe Mutations::SignInUser, type: :request do
  let!(:user) { create :user }

  it 'signs in user with correct params' do
    query =
      <<~GQL
          mutation {
	          signinUser(input: {
              email: "#{user.email}",
              password: "#{user.password}"
            }) {
	            token
              errors {
                message       
              }
	          }
          }
      GQL

    post '/graphql', params: { query: query }
    expect(json.dig('data', 'signinUser', 'token')).to be
    expect(json.dig('data', 'signinUser', 'errors')).to eq []
  end

  it 'fails with missing email' do

    query =
      <<~GQL
          mutation {
	          signinUser(input: {
              email: "",
              password: "#{user.password}"
            }) {
	            token
              errors {
                message       
              }
	          }
          }
      GQL

    post '/graphql', params: { query: query }
    expect(json.dig('data', 'signinUser', 'token')).to be nil
    expect(json.dig('data', 'signinUser', 'errors').count).to eq 1
    expect(json.dig('data', 'signinUser', 'errors').first["message"]).to eq "email or password is invalid"
  end

  it 'fails with incorrect password' do
    query =
        <<~GQL
          mutation {
	          signinUser(input: {
              email: "#{user.email}",
              password: "scoobydoo"
            }) {
	            token
              errors {
                message       
              }
	          }
          }
    GQL

    post '/graphql', params: { query: query }
    expect(json.dig('data', 'signinUser', 'token')).to be nil
    expect(json.dig('data', 'signinUser', 'errors').count).to eq 1
    expect(json.dig('data', 'signinUser', 'errors').first["message"]).to eq "email or password is invalid"
  end

end
