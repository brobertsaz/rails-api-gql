# frozen_string_literal: true

class Types::GenderType < GraphQL::Schema::Object
  graphql_name 'GenderType'

  field :id, ID, null: false
  field :name, String, null: false
end
