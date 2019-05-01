require 'spec_helper'

describe Types::AffiliationType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        id
        name
        users
      ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }
  it { expect(described_class.fields['name'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['users'].type.to_type_signature).to eq("[UserType!]!") }
end
