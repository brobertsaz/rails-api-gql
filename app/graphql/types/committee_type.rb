# frozen_string_literal: true

class Types::CommitteeType < GraphQL::Schema::Object
  graphql_name 'CommitteeType'

  field :id, ID, null: false
  field :name, String, null: false
  field :bioguide_id, String, null: false
end
