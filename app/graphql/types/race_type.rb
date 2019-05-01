# frozen_string_literal: true

class Types::RaceType < GraphQL::Schema::Object
  graphql_name 'RaceType'

  field :id, ID, null: false
  field :name, String, null: false
end
