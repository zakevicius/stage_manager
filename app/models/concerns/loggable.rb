# frozen_string_literal: true

module Loggable
  extend ActiveSupport::Concern

  def create_log
    log = @loggable.logs.build(action: stage_params[:action], action_made_by: stage_params[:claimed_by])
    log.save
  end
end
