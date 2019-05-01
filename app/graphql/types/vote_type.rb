# frozen_string_literal: true

class Types::VoteType < GraphQL::Schema::Object
  graphql_name 'VoteType'

  field :id, ID, null: false
  field :position, Types::Enums::VotePositionEnumType, null: false

  field :chamber, Types::ChamberType, null: true
  field :bill, Types::BillType, null: true
  field :member, Types::MemberType, null: true
end
