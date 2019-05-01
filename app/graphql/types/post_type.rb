# frozen_string_literal: true

class Types::PostType < GraphQL::Schema::Object
  graphql_name 'PostType'

  field :id, ID, null: false

  field :body, String, null: false
  field :kind, Types::Enums::PostKindEnumType, null: false
  field :publish_at, GraphQL::Types::ISO8601DateTime, null: false
  field :source, String, null: false
  field :state, Types::Enums::PostStateEnumType, null: false
  field :title, String, null: false
  field :topic, Types::TopicType, null: true
  field :url, String, null: true
end
