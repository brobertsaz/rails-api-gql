# frozen_string_literal: true

class Position < ApplicationRecord
  # Associations
  belongs_to :bill
  belongs_to :user

  # Class Methods
  def self.for(user, bill)
    find_by(user: user, bill: bill).try(:state)
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
