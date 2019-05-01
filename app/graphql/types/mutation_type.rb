# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :favorite_bill, mutation: Mutations::FavoriteBill
  end
end