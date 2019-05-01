# frozen_string_literal: true

class Types::StateType < GraphQL::Schema::Object
  graphql_name 'StateType'

  field :id, ID, null: false
  field :name, String, null: false
  field :abbreviation, String, null: false
end
