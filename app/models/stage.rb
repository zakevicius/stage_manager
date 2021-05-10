# frozen_string_literal: true

class Stage < ApplicationRecord
  include Loggable

  serialize :actions, Array
  enum status: { unclaimed: 0, claimed: 1 }

  has_many :logs
end
