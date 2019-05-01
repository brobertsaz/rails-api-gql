# frozen_string_literal: true

class Types::ChamberType < GraphQL::Schema::Object
  graphql_name 'ChamberType'

  field :id, ID, null: false
  field :name, String, null: false

  field :members, [Types::MemberType], null: false
  field :votes, [Types::VoteType], null: false
end
