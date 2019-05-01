module Types
  class Enums::FeatureStateEnumType < Types::BaseEnum
    description 'Feature state of a bill'

    value 'unfeatured', 'Unfeatured state'
    value 'featured', 'Featured state'
    value 'highlighted', 'Highlighted state'
  end
end
