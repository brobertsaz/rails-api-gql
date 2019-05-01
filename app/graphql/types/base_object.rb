module Types
  class BaseObject < GraphQL::Schema::Object
      
    # def ensure_current_user
    #   current_user = context[:current_user]
    #   raise GraphQL::ExecutionError, 'Not authorized' unless current_user

    #   current_user
    # end
  end
end
