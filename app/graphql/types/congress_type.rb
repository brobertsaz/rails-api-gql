# frozen_string_literal: true

class Types::CongressType < GraphQL::Schema::Object
  graphql_name 'CongressType'

  field :id, ID, null: false
  field :number, Int, null: false
end
