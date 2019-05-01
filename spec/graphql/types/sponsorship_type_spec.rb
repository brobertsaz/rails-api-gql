require 'spec_helper'

describe Types::SponsorshipType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
          id
          bill
          kind
          member
        ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }
  it { expect(described_class.fields['bill'].type.to_type_signature).to eq('BillType') }
  it { expect(described_class.fields['kind'].type.to_type_signature).to eq('SponsorshipTypeEnum!') }
  it { expect(described_class.fields['member'].type.to_type_signature).to eq('MemberType') }
end
