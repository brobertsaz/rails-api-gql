require 'rails_helper'
require 'factory_bot'

describe Administrator do
  let(:admin) { create(:administrator, name: 'Admin User') }

  describe 'to_s' do
    it 'returns the admin name' do
      expect(admin.to_s).to eql('Admin User')
    end
  end

  describe 'first_name' do
    it 'splits the first name of the admin' do
      expect(admin.first_name).to eql('Admin')
    end
  end

  describe 'last_name' do
    it 'splits the last name of the admin' do
      expect(admin.last_name).to eql('User')
    end
  end
end
