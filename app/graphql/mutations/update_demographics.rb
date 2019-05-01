# frozen_string_literal: true

module Mutations
  class UpdateDemographics < Mutations::Base
    argument :gender, String, required: false
    argument :race, String, required: false
    argument :affiliation, String, required: false
    argument :election_2016, Boolean, required: false
    argument :birth_year, Int, required: false
    
    def resolve(gender:, race:, affiliation:, election_2016:, birth_year: )
      current_user = ensure_current_user

      current_user.gender         = Gender.find_by(name: gender)
      current_user.race           = Race.find_by(name: race)
      current_user.affiliation    = Affiliation.find_by(name: affiliation)
      current_user.voted_in_2016  = election_2016
      current_user.birth_year     = birth_year

      current_user.save!

      {
        errors: user_errors(current_user.errors),
        user: current_user.valid? ? current_user : nil
      }
    end
  end
end