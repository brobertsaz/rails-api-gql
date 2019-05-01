# frozen_string_literal: true

module Mutations
  class FavoriteMember < Mutations::Base
    argument :member_id, ID, required: true
    
    def resolve(member_id:)
      current_user = ensure_current_user
      member = Member.find(member_id)

      if current_user.favorites.exists?(favoritable: member)
        current_user.favorites.find_by(favoritable: member).destroy
      else
        current_user.favorites.create(favoritable: member)
      end

      {
        errors: user_errors(member.errors),
        member: member.valid? ? member : nil
      }
    end
  end
end