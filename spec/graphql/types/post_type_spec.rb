require 'spec_helper'

describe Types::PostType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        id
        body
        kind
        publishAt
        source
        state
        title
        topic
        url
      ]
    )
  end

  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }

  it { expect(described_class.fields['body'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['kind'].type.to_type_signature).to eq('PostKindEnum!') }
  it { expect(described_class.fields['publishAt'].type.to_type_signature).to eq('ISO8601DateTime!') }
  it { expect(described_class.fields['source'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['state'].type.to_type_signature).to eq('PostStateEnum!') }
  it { expect(described_class.fields['title'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['topic'].type.to_type_signature).to eq('TopicType') }
  it { expect(described_class.fields['url'].type.to_type_signature).to eq('String') }
end
