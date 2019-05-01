require 'spec_helper'

describe Types::UserType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        id
        name
        email
        affiliation
        billsShowIntro
        birthYear
        dashboardsShowIntro
        gender
        membersIndexIntro
        race
        state
        votedIn2016
      ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }
  it { expect(described_class.fields['name'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['affiliation'].type.to_type_signature).to eq("AffiliationType") }
  it { expect(described_class.fields['billsShowIntro'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['birthYear'].type.to_type_signature).to eq('Int') }
  it { expect(described_class.fields['dashboardsShowIntro'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['gender'].type.to_type_signature).to eq('GenderType') }
  it { expect(described_class.fields['membersIndexIntro'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['race'].type.to_type_signature).to eq('RaceType') }
  it { expect(described_class.fields['state'].type.to_type_signature).to eq('StateType') }
  it { expect(described_class.fields['votedIn2016'].type.to_type_signature).to eq('Boolean') }
end
