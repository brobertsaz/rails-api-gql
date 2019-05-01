require 'spec_helper'

describe Mutations::CreateUser do
  def perform(args = {})
    described_class.new(object: nil, context: {}).resolve(args)
  end

  it 'creates a new user' do
    result = perform(
        name: 'Test User',
        email: 'email@example.com',
        password: 'password'
    )

    user = result[:user]

    expect(user).to be_persisted
    expect(user.name).to eq('Test User')
    expect(user.email).to eq('email@example.com')
  end
end
