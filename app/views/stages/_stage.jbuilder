# frozen_string_literal: true

json.call(stage, :id, :stage_id, :status, :last_deployment_made_by, :actions, :claimed_since)
json.logs do
  json.array! stage.logs.recent do |log|
    json.call(log, :action_made_by, :action, :created_at)
  end
end
