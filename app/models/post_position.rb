# frozen_string_literal: true

class PostPosition < ApplicationRecord
  # Associations
  belongs_to :post
  belongs_to :user

  # Class Methods
  def self.for(user, post)
    find_by(user: user, post: post).try(:state)
  end

  # Methods
  def upvote!
    update!(position: 1)
  end

  def downvote!
    update!(position: -1)
  end

  def novote!
    update!(position: 0)
  end

  def upvoted?
    position == 1
  end

  def downvoted?
    position == -1
  end

  def state
    return :upvoted if upvoted?
    return :downvoted if downvoted?

    nil
  end
end
