json.call(stage, :id, :stage, :status, :last_deployment_made_by, :actions, :claimed_since)
json.logs do
  json.array! stage.logs.last(10) do |log|
    json.call(log, :action_made_by, :action, :created_at)
  end
end
