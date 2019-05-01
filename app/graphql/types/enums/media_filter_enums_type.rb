module Types
  class Enums::MediaFilterEnumsType < Types::BaseEnum
    description 'Media filters for bills, post, and members'

    value 'article', 'Article'
    value 'video', 'Video'
    value 'legislation', 'Legislation'
  end
end
