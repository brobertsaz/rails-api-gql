require 'spec_helper'

describe Types::ChamberType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        id
        name
        members
        votes
      ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }
  it { expect(described_class.fields['name'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['members'].type.to_type_signature).to eq("[MemberType!]!") }
  it { expect(described_class.fields['votes'].type.to_type_signature).to eq("[VoteType!]!") }
end
