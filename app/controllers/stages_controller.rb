# frozen_string_literal: true

class StagesController < ApplicationController
  include Authenticate
  include Loggable
  include Errorable

  before_action :authenticate
  before_action :set_stages, only: :index
  before_action :set_stage, only: %i[show update]
  after_action :create_log, only: %i[claim_stage unclaim_stage]

  def index
  end

  def show
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

  def set_stages
    @stages = Stage.all
  end

  def stage_params
    params.require(:stage).permit(:id, :action, :claimed_by)
  end

  def claim_stage
    return render_error "Stage ##{@stage.stage} is currently claimed!" if @stage.claimed?

    new_stage_params = {
      claimed_since: Time.now,
      last_deployment_made_by: stage_params[:claimed_by],
      status: 1
    }

    render json: @stage.update(new_stage_params) ? @stage : { errors: @stage.errors.full_messages }
  end

  def unclaim_stage
    return render json: { error: "Stage ##{@stage.stage} is already unclaimed!" } if @stage.unclaimed?

    new_stage_params = {
      claimed_since: nil,
      last_deployment_made_by: nil,
      status: 0
    }

    render json: @stage.update(new_stage_params) ? @stage : { errors: @stage.errors.full_messages }
  end
end
