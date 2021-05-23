# frozen_string_literal: true

class StagesController < ApplicationController
  include Authenticate
  include Loggable
  include Errorable

  before_action :authenticate
  before_action :set_stages, only: :index
  before_action :set_stage, only: %i[show update]

  after_action :create_log, only: %i[update], if: -> { response.successful? }

  def index; end

  def show; end

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

  def log_params
    { action: stage_params[:action], made_by: stage_params[:claimed_by] }
  end

  def claim_stage
    return render_error "Stage ##{@stage.stage_id} is currently claimed!" if @stage.claimed?

    @stage.claim!(stage_params) ? render(json: @stage) : render_error('Encountered errors while claiming stage.')
  end

  def unclaim_stage
    return render_error "Stage ##{@stage.stage_id} is already unclaimed!" if @stage.unclaimed?

    @stage.unclaim! ? render(json: @stage) : render_error('Encountered errors while unclaiming stage.')
  end
end
