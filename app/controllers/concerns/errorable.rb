# frozen_string_literal: true

module Errorable
  extend ActiveSupport::Concern

  def render_error(error, status = 200)
    render json: { error: error }, status: status
  end
end
