require 'spec_helper'

describe Types::UserErrorType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        message
        path
      ]
    )
  end

  it { expect(described_class.fields['message'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['path'].type.to_type_signature).to eq('String') }
end
