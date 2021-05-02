# frozen_string_literal: true

class Stage < ApplicationRecord
  serialize :actions, Array
  enum status: { unclaimed: 0, claimed: 1 }

  has_many :histories
end
