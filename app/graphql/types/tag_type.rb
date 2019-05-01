# frozen_string_literal: true

class Types::TagType < GraphQL::Schema::Object
  graphql_name 'TagType'

  field :id, ID, null: false
  field :name, String, null: false
end
