# frozen_string_literal: true

class StagesController < ApplicationController
  include Authenticate
  include Loggable
  include Errorable

  before_action :authenticate
  before_action :set_stage, only: %i[show update]

  def index
    render json: Stage.all
  end

  def show
    render json: @stage
  end

  def update
    case stage_params[:action]
    when 'claim'
      claim_stage
    when 'unclaim'
      unclaim_stage
    else
      render_error "Unknown action #{stage_params[:action]}"
    end
  end

  private

  def set_stage
    @loggable = @stage = Stage.find(params[:id])
  end

  def stage_params
    params.require(:stage).permit(:id, :action, :claimed_by)
  end

  def log_params
    claimed_by, action = stage_params.values_at(:claimed_by, :action)
    {
      action_made_by: claimed_by || nil,
      action: action
    }
  end

  def claim_stage
    return render_error "Stage ##{@stage.stage} is currently claimed!" if @stage.claimed?

    new_stage_params = {
      claimed_since: Time.now,
      last_deployment_made_by: stage_params[:claimed_by],
      status: 1
    }

    render json: @stage.update(new_stage_params) ? @stage : { errors: @stage.errors.full_messages }
    create_log
  end

  def unclaim_stage
    return render json: { error: "Stage ##{@stage.stage} is already unclaimed!" } if @stage.unclaimed?

    new_stage_params = {
      claimed_since: nil,
      last_deployment_made_by: nil,
      status: 0
    }

    render json: @stage.update(new_stage_params) ? @stage : { errors: @stage.errors.full_messages }
    create_log
  end
end
