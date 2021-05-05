# frozen_string_literal: true

class StagesController < ApplicationController
  include Authenticate

  before_action :authenticate
  before_action :set_stage, only: %i[show update]

  def index
    render json: Stage.all
  end

  def show
    render json: @stage
  end

  def update
    new_stage_params = {}

    case params[:action]
    when 'claim'
      new_stage_params = {
        claimed_since: Time.now,
        last_deployment_made_by: params[:claimed_by],
        status: 1
      }
    when 'unclaim'
      new_stage_params = {
        claimed_since: nil,
        status: 0
      }
    else
      render json: { error: "Unknown action #{params[:action]}" }
    end

    if @stage.update(new_stage_params)
      render json: @stage
    else
      render json: { errors: @stage.errors.full_messages }
    end
  end

  private

  def set_stage
    @stage = Stage.find(params[:id])
  end

  def stage_params
    params.require(:stage).permit(:id, :action, :claimed_by)
  end
end
