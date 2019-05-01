# frozen_string_literal: true

class Types::SponsorshipType < GraphQL::Schema::Object
  graphql_name 'SponsorshipType'

  field :id, ID, null: false
  field :kind, Types::Enums::SponsorshipTypeEnumType, null: false
  field :bill, Types::BillType, null: true
  field :member, Types::MemberType, null: true
end
