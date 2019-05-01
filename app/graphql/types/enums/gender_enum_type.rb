# frozen_string_literal: true

module Types
  class Enums::GenderEnumType < Types::BaseEnum
    description 'Gender for members'

    value 'male', 'Male'
    value 'female', 'Female'
  end
end
