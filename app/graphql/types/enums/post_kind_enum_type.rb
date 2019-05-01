module Types
  class Enums::PostKindEnumType < Types::BaseEnum
    description 'The kind or type of a post'

    value 'post', 'Standard Post'
    value 'article', 'Article Post' 
    value 'video', 'Video Post' 
  end
end
