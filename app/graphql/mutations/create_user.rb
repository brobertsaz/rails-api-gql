# frozen_string_literal: true

module Mutations
  class CreateUser < Mutations::Base
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [Types::UserErrorType], null: false

    def resolve(name:, email:, password:)
      user = User.create(
        name: name,
        email: email,
        password: password
      )

      {
        errors: user_errors(user.errors),
        user: user.valid? ? user : nil
      }
    end
  end
end