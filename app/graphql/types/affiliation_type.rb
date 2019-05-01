# frozen_string_literal: true

class Types::AffiliationType < GraphQL::Schema::Object
  graphql_name 'AffiliationType'

  field :id, ID, null: false
  field :name, String, null: false
  field :users, [Types::UserType], null: false
end
