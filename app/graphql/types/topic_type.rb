# frozen_string_literal: true

class Types::TopicType < GraphQL::Schema::Object
  graphql_name 'TopicType'

  field :id, ID, null: false
  field :name, String, null: false
  field :slug, String, null: false
end
