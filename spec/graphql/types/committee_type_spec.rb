require 'spec_helper'

describe Types::CommitteeType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        id
        name
        bioguideId
      ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }
  it { expect(described_class.fields['name'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['bioguideId'].type.to_type_signature).to eq('String!') }
end
