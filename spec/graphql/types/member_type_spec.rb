require 'spec_helper'

describe Types::MemberType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        id
        bio
        bioguideId
        chamber
        dateOfBirth
        facebook
        fax
        firstName
        gender
        inOffice
        lastName
        leadershipRole
        middleName
        name
        officeAddress
        party
        phone
        shortTitle
        slug
        state
        suffix
        title
        twitter
        url
        youtube
      ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }

  it { expect(described_class.fields['bio'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['bioguideId'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['chamber'].type.to_type_signature).to eq('ChamberType!') }
  it { expect(described_class.fields['dateOfBirth'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['facebook'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['fax'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['firstName'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['gender'].type.to_type_signature).to eq('GenderEnum!') }
  it { expect(described_class.fields['inOffice'].type.to_type_signature).to eq('Boolean!') }
  it { expect(described_class.fields['lastName'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['leadershipRole'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['middleName'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['name'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['officeAddress'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['party'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['phone'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['shortTitle'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['slug'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['state'].type.to_type_signature).to eq('StateType!') }
  it { expect(described_class.fields['suffix'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['title'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['twitter'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['url'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['youtube'].type.to_type_signature).to eq('String') }
end
