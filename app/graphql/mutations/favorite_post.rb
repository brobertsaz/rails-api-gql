# frozen_string_literal: true

module Mutations
  class FavoritePost < Mutations::Base
    argument :post_id, ID, required: true
    
    def resolve(post_id:)
      current_user = ensure_current_user
      post = Post.find(post_id)

      if current_user.favorites.exists?(favoritable: post)
        current_user.favorites.find_by(favoritable: post).destroy
      else
        current_user.favorites.create(favoritable: post)
      end

      {
        errors: user_errors(post.errors),
        post: post.valid? ? post : nil
      }
    end
  end
end