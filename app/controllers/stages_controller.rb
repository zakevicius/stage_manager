# frozen_string_literal: true

class StagesController < ApplicationController
  before_action :set_stage, only: %i[show update]
  ACTIONS = %w[claim unclaim].freeze

  def index
    render json: Stage.all
  end

  def show
    render json: @stage
  end

  def update
    stage_params = {}

    case params[:action]
    when ACTIONS[0]
      stage_params = {
        claimed_since: Time.now,
        last_deployment_made_by: params[:claimed_by]
      }
      @stage.claimed!
    when ACTIONS[1]
      stage_params = {
        claimed_since: nil
      }
      @stage.unclaimed!
    else
      render json: { error: "Unknown action #{params[:action]}" }
    end

    if @stage.update(stage_params)
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
