# frozen_string_literal: true

class Stage < ApplicationRecord
  serialize :actions, Array
  enum status: { unclaimed: 0, claimed: 1 }

  has_many :logs

  def claim!(params)
    update(claimed_since: Time.now, last_deployment_made_by: params[:claimed_by], status: 1)
  end
  alias claimed! claim!

  def unclaim!
    update(claimed_since: nil, last_deployment_made_by: nil, status: 0)
  end
  alias unclaimed! unclaim!
end
