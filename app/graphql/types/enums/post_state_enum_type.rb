module Types
  class Enums::PostStateEnumType < Types::BaseEnum
    description 'The current state of a post'

    value 'draft', 'Draft state'
    value 'published', 'Published state'    
  end
end
