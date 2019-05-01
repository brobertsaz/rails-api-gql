module Types
  class Enums::VotePositionEnumType < Types::BaseEnum
    description 'The vote position'

    value 'yes', 'Yes vote'
    value 'no', 'No vote' 
    value 'not_voting', 'Not voting' 
    value 'speaker', 'Speaker' 
    value 'present', 'Present' 
  end
end
