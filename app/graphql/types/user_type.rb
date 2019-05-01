# frozen_string_literal: true

class Types::UserType < GraphQL::Schema::Object
  graphql_name 'UserType'

  field :id, ID, null: false
  field :name, String, null: false
  field :email, String, null: false
  field :state, Types::StateType, null: true
  field :race, Types::RaceType, null: true
  field :gender, Types::GenderType, null: true
  field :affiliation, Types::AffiliationType, null: true

  field :dashboards_show_intro, GraphQL::Types::ISO8601DateTime, null: true
  field :members_index_intro, GraphQL::Types::ISO8601DateTime, null: true
  field :bills_show_intro, GraphQL::Types::ISO8601DateTime, null: true
  field :birth_year, Int, null: true
  field :voted_in_2016, Boolean, null: true
end
