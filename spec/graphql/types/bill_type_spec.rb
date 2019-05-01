require 'spec_helper'

describe Types::BillType do
  it 'includes the expected fields' do
    expect(described_class.fields.keys).to match_array(
      %w[
        breakdown
        congress
        cosponsors
        diggingDeeper
        enactedOn
        featurePosition
        featureState
        forLeft
        forRight
        fullTextUrl
        houseResult
        houseVotedOn
        id
        introducedOn
        isVisible
        number
        senateResult
        senateVotedOn
        slug
        summary
        title
        topic
        veteodOn
        downvotePercentage
        sponsor
        sponsors
        upvotePercentage
        votes
      ]
    )
  end
  it { expect(described_class.fields['id'].type.to_type_signature).to eq('ID!') }

  it { expect(described_class.fields['breakdown'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['congress'].type.to_type_signature).to eq('CongressType!') }
  it { expect(described_class.fields['cosponsors'].type.to_type_signature).to eq('[MemberType!]!') }
  it { expect(described_class.fields['diggingDeeper'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['enactedOn'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['featurePosition'].type.to_type_signature).to eq('Int') }
  it { expect(described_class.fields['featureState'].type.to_type_signature).to eq('FeatureStateEnum') }
  it { expect(described_class.fields['forLeft'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['forRight'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['fullTextUrl'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['houseResult'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['houseVotedOn'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['introducedOn'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['isVisible'].type.to_type_signature).to eq('Boolean') }
  it { expect(described_class.fields['number'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['senateResult'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['senateVotedOn'].type.to_type_signature).to eq('ISO8601DateTime') }
  it { expect(described_class.fields['slug'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['summary'].type.to_type_signature).to eq('String') }
  it { expect(described_class.fields['title'].type.to_type_signature).to eq('String!') }
  it { expect(described_class.fields['topic'].type.to_type_signature).to eq('TopicType') }
  it { expect(described_class.fields['veteodOn'].type.to_type_signature).to eq('ISO8601DateTime') }
end
