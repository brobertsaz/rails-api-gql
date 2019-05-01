require 'spec_helper'

describe Mutations::UpdateDemographics do
  let!(:user) { create :user }
  let!(:gender) { create :gender }
  let!(:race) { create :race }
  let!(:affiliation) { create :affiliation }

  def perform(args = {})
    described_class.new(object: nil, context: { current_user: user }).resolve(args)
  end

  it 'updates a users demographics' do
    result = perform(
        gender: gender.name,
        race: race.name,
        affiliation: affiliation.name,
        election_2016: true,
        birth_year: 1980
    )

    user = result[:user]
    expect(user.gender.name).to eq gender.name
    expect(user.race.name).to eq race.name
    expect(user.affiliation.name).to eq affiliation.name
    expect(user.voted_in_2016).to be true
    expect(user.birth_year).to eq 1980
  end
end