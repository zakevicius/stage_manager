# frozen_string_literal: true

module Authenticate
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActiveSupport::SecurityUtils

  private

  def authenticate
    @session = authenticate_with_http_token do |token, _options|
      secure_compare(token, Rails.application.credentials.api_secure_token)
    end
    render_unauthorized unless @session.present?
  end

  def render_unauthorized
    render json: 'unauthorized', status: 401
  end
end
