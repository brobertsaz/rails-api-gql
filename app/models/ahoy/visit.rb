# frozen_string_literal: true

class Ahoy::Visit < ApplicationRecord
  self.table_name = 'ahoy_visits'

  has_many :events, class_name: 'Ahoy::Event'
  belongs_to :user, optional: true
  counter_culture :user
end
