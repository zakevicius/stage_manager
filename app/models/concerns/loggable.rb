# frozen_string_literal: true

module Loggable
  extend ActiveSupport::Concern

  def create_log
    log = @loggable.logs.build(action: log_params[:action], action_made_by: log_params[:made_by])
    log.save
  end
end
