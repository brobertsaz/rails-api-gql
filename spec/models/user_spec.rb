require 'rails_helper'
require 'factory_bot'

describe User do
  let(:user) { create(:user, name: 'John Doe', email: 'johndoe@gmail.com') }

  describe 'first_name' do
    it 'splits the first name of the user' do
      expect(user.first_name).to eql('John')
    end
  end

  describe 'last_name' do
    it 'splits the last name of the user' do
      expect(user.last_name).to eql('Doe')
    end
  end

  describe 'formatted_email' do
    it 'returns name <email>' do
      expect(user.formatted_email).to eql('John Doe <johndoe@gmail.com>')
    end
  end
end
