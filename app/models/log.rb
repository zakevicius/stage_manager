# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :stage

  scope :recent, -> { order(created_at: :desc).limit(10) }
end
