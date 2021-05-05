# frozen_string_literal: true

module Authenticate
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActiveSupport::SecurityUtils

  private

  def authenticate
    authenticate_with_http_token do |token, _options|
      render_unauthorized unless secure_compare(token, Rails.application.credentials.api_secure_token)
    end
  end

  def render_unauthorized
    render json: 'unauthorized', status: 401
  end
end
