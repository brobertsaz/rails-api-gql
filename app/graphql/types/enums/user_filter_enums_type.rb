module Types
  class Enums::UserFilterEnumsType < Types::BaseEnum
    description 'User filters for bills, post, and members'

    value 'following', 'Following'
    value 'state', 'State'
  end
end
