# frozen_string_literal: true

module Mutations
  class FavoriteBill < Mutations::Base
    argument :bill_id, ID, required: true
    
    def resolve(bill_id:)
      current_user = ensure_current_user
      bill = Bill.find(bill_id)

      if current_user.favorites.exists?(favoritable: bill)
        current_user.favorites.find_by(favoritable: bill).destroy
      else
        current_user.favorites.create(favoritable: bill)
      end

      {
        errors: user_errors(bill.errors),
        bill: bill.valid? ? bill : nil
      }
    end
  end
end