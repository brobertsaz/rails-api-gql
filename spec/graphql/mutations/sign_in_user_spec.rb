require 'rails_helper'

describe Mutations::SignInUser do
  let!(:user) { create :user }

  def perform(args)
    described_class.new(object: nil, context: {}).resolve(args)
  end

  it 'creates a token' do
    result = perform(
        email: user.email,
        password: user.password
    )

    expect(result).to be_present
    expect(result[:token]).to be_present
    expect(result[:user]).to eq(user)
  end

  it 'handles no credentials' do
    expect(perform(email: nil, password: nil)).to eq(
      errors: [UserError.new('email or password is invalid')])
  end

  it 'handles wrong email' do
    expect(perform(email: 'wrong', password: nil)).to eq(
      errors: [UserError.new('email or password is invalid')])
  end

  it 'handles wrong password' do
    expect(perform(email: user.email, password: 'wrong')).to eq(
      errors: [UserError.new('email or password is invalid')])
  end
end
