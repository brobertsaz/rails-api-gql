require 'spec_helper'

describe Types::CongressType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        id
        number
      ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }
  it { expect(described_class.fields['number'].type.to_type_signature).to eq('Int!') }
end
